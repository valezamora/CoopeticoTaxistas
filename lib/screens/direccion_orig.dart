///----------------------------------------------------------------------------
/// Imports
import 'dart:async';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/screens/direccion_dest.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
/// TODO: PARA HACER ESTA CIPORT FUNCIONAR BIEN, DEBEN SEGUIRSE LOS PASOS
/// TODO: QUE SE DESCRIBEN EN LA SIGUIENTE PÁGINA: 
/// TODO: https://pub.dev/packages/location
import 'package:location/location.dart';
///----------------------------------------------------------------------------
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
///----------------------------------------------------------------------------
// Google Maps
import 'package:google_maps_flutter/google_maps_flutter.dart';
///----------------------------------------------------------------------------
//Modelos
import 'package:CoopeticoTaxiApp/models/trip_info_res.dart';
import 'package:CoopeticoTaxiApp/models/place_res.dart';
import 'package:CoopeticoTaxiApp/models/step_res.dart';
///----------------------------------------------------------------------------
//Servicios
import 'package:CoopeticoTaxiApp/services/google_maps_places.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
///----------------------------------------------------------------------------
//Colores
import 'package:CoopeticoTaxiApp/util/paleta.dart';
///----------------------------------------------------------------------------
/// Pantalla que muestra la ruta de la dirección actual del taxista y la
/// dirección de origen del viaje.
///
/// Autor: Joseph Rementería (b55824).
/// Fecha: 18-05-2019.
///----------------------------------------------------------------------------
///
class DireccionOrigen extends StatefulWidget {
  //---------------------------------------------------------------------------
  // Los datos que se traen desde la pantalla anterior
  final ViajeComenzando datosIniciales;
  //---------------------------------------------------------------------------
  DireccionOrigen(this.datosIniciales);
  //---------------------------------------------------------------------------
  @override
  _DireccionOrigenState createState() => _DireccionOrigenState(datosIniciales);
//---------------------------------------------------------------------------
}
///----------------------------------------------------------------------------
class _DireccionOrigenState extends State<DireccionOrigen> {
  ///--------------------------------------------------------------------------
  /// Variables globales.
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, Marker> _markers = <String, Marker>{};
  /// Si el centro el San Diego, entonces hay un error al recibir la dir de org
  LatLng _center = LatLng(9.901589, -84.009813);
  GoogleMapController _mapController;
  RestService _restService = new RestService();
  /// TODO: obtener el correo del taxista actual.
  String correoTaxista; ///= 'taxista1@taxista.com';
  ViajeComenzando datosIniciales;
  double origenLatitud;
  double origenLongitud;
  double currentLatitud;
  double currentLongitud;
  ///--------------------------------------------------------------------------
  /// Constantes
  final String MARKER_ID_INICIO = "current";
  final String MARKER_ID_FIN = "origen";
  final String COMENZAR_VIAJE_MENSAJE_BOTON = 'Comenzar Viaje';
  final String TITULO_DIR_OPERADORA = 'Indicaciones';
  final int REFRESHING_RATIO = 3;
  ///--------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    TokenService.getSub().then( (val) => setState(() {
      correoTaxista = val;
    }));
    if (datosIniciales.origen[0] != '\$') {
      Timer.periodic(Duration(seconds: REFRESHING_RATIO),
        (Timer t) => this._dibujarRuta(context));
    } else {
      WidgetsBinding.instance
        .addPostFrameCallback((_) => _mostrarOrigenOperador(context));
      Timer.periodic(Duration(seconds: REFRESHING_RATIO),
        (Timer t) => _actualizarUbicacion());
    }
  }
  ///--------------------------------------------------------------------------
  /// Constructor del despliegue original
  _DireccionOrigenState (ViajeComenzando datosIniciales) {
    this.datosIniciales = datosIniciales;
    if (datosIniciales.origen[0] != '\$'){
      var origenArray = datosIniciales.origen.split(',');
      this.origenLatitud = double.parse(origenArray[0]);
      this.origenLongitud = double.parse(origenArray[1]);
      _center = LatLng(origenLatitud,origenLongitud);
    } else {
      /// TODO: find if there's another action
    }

  }
  ///--------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    ///------------------------------------------------------------------------
    return Scaffold(
      ///----------------------------------------------------------------------
      key: _scaffoldKey,
      ///----------------------------------------------------------------------
      body: Container(
        ///--------------------------------------------------------------------
        constraints: BoxConstraints.expand(),
        color: Paleta.Blanco,
        ///--------------------------------------------------------------------
        child: Stack(
          ///------------------------------------------------------------------
          alignment: Alignment.bottomCenter,
          ///------------------------------------------------------------------
          children: <Widget>[
            ///----------------------------------------------------------------
            /// Mapa de google.
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                /// zoom: 14.4746,
                zoom: 20.0
              ),
              myLocationEnabled: true,
            ),
            ///----------------------------------------------------------------
            /// Botón de comenzar viaje.
            Positioned(
              bottom: 50,
              child:  Boton(
                COMENZAR_VIAJE_MENSAJE_BOTON,
                Paleta.Verde,
                Paleta.Blanco,
                onPressed: () {this._comenzarViaje();}
                ///------------------------------------------------------------
              )
            )
            ///----------------------------------------------------------------
          ],
          ///------------------------------------------------------------------
          )
        ///--------------------------------------------------------------------
        ),
      ///----------------------------------------------------------------------
    );
    ///------------------------------------------------------------------------
  }
  ///------------------------------Métodos-------------------------------------
  /// Método que se utiliza cuando se selecciona alguna dirección (RidePicker)
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  /// Editado por: Joseph Rementería (b55824); Fecha: 24-05-2019
  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? MARKER_ID_INICIO : MARKER_ID_FIN;
    _addMarker(mkId, place);
    _moveCamera();
    _checkDrawPolyline();
  }
  ///--------------------------------------------------------------------------
  /// Método que se utiliza para borrar un marcador
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  void clearMarker(bool fromAddress){
    _clearMarker(fromAddress);
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza para agregar un marcador en el mapa de Google
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  /// Editado por: Joseph Rementería (b55824)
  void _addMarker(String mkId, PlaceItemRes place) async {
    _markers.remove(mkId);
    _mapController.clearMarkers();
    ///------------------------------------------------------------------------
    /// Esta sección cambia el ícono dependiendo de si es el del taxista o el
    /// del usuario.
    BitmapDescriptor icono;
    if (mkId != this.MARKER_ID_INICIO) {
      icono = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueOrange
      );
    } else {
      icono = BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure
      );
    }
    ///------------------------------------------------------------------------
    _markers[mkId] = Marker(
      mkId,
      MarkerOptions(
        position: LatLng(place.lat, place.lng),
        infoWindowText: InfoWindowText(place.name, place.address),
        ///--------------------------------------------------------------------
        icon: icono
        ///--------------------------------------------------------------------
      )
    );

    for (var m in _markers.values){
       _mapController.addMarker(m.options);
    }
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza para mover la cámara a alguna dirección
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  /// Editador por: Joseph Rementería (b55824); Fecha: 24-05-2019.
  void _moveCamera() {
    if (_markers.values.length > 1) {
      var fromLatLng = _markers[MARKER_ID_INICIO].options.position;
      var toLatLng = _markers[MARKER_ID_FIN].options.position;

      var sLat, sLng, nLat, nLng;
      if(fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if(fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      } PositionedTransition;

      LatLngBounds bounds = LatLngBounds(
          northeast: LatLng(nLat, nLng),
          southwest: LatLng(sLat, sLng)
      );
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(
        _markers.values.elementAt(0).options.position));
    }
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza trazar una ruta entre 2 direcciones.
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  /// Editador por: Joseph Rementería (b55824); Fecha: 24-05-2019.
  void _checkDrawPolyline() {
    _mapController.clearPolylines();

    if (_markers.length > 1) {
      var from = _markers[MARKER_ID_INICIO].options.position;
      var to = _markers[MARKER_ID_FIN].options.position;
      PlaceService.getStep(
          from.latitude, from.longitude, to.latitude, to.longitude)
          .then((vl) {
        TripInfoRes infoRes = vl;
        setState(() {
        });
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths.add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }

        _mapController.addPolyline(PolylineOptions(
            points: paths, color: Paleta.Naranja.value, width: 10));
      });
    }
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza para eliminar un marcador.
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  /// Editador por: Joseph Rementería (b55824); Fecha: 24-05-2019.
  void _clearMarker(bool fromAddress){
    var mkId = fromAddress ? MARKER_ID_INICIO : MARKER_ID_FIN;
    _mapController.clearPolylines();
    setState(() {
      _mapController.markers.forEach((marker){
        if(marker == _markers[mkId]){
          _mapController.removeMarker(marker);
        }
      });
    });
    ///------------------------------------------------------------------------
  }
  ///--------------------------------------------------------------------------
  /// Envíá los datos necesarios al backend para crear una tupla en la tabla
  /// viaje.
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 19-05-2019
  ///--------------------------------------------------------------------------
  Future _comenzarViaje() async {
    ///------------------------------------------------------------------------
    /// Acá se recopilian los datos para crear la tupla.
    /// TODO: la placa para este sprint no es algo que se pueda obtener.
    String placa = "AAA111";
    var timestamp = DateTime.now().toString().split(' ');
    String fechaInicio = timestamp[0] + " " + timestamp[1].split(".")[0];
    String origen = this.datosIniciales.origen;
    String correoCliente = this.datosIniciales.correoCliente;
    ///------------------------------------------------------------------------
    String codigo = await _restService.crearViaje(
      placa,
      this.correoTaxista,
      fechaInicio,
      origen,
      correoCliente
    );
    ///------------------------------------------------------------------------
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context) =>
        new DireccionDestino(this.datosIniciales, fechaInicio)));
    ///------------------------------------------------------------------------
  }

  ///--------------------------------------------------------------------------
  /// Dibuja la ruta y actualiza los puntos de dirección actual y dirección
  /// de origen.
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 24-05-2019
  void _dibujarRuta(BuildContext context) async {
    ///------------------------------------------------------------------------
    /// Dibuja el marcador de la ubicación de origen.
    this._addMarker(
      MARKER_ID_FIN,
      new PlaceItemRes(
          MARKER_ID_FIN,
          'test',
          this.origenLatitud,
          this.origenLongitud
      )
    );
    ///------------------------------------------------------------------------
    /// Calcula la ubicación actual del taxista y se la envía la backend.
    try {
      this._actualizarUbicacion();
    } catch (Exception) {

    }
    ///------------------------------------------------------------------------
    /// Dibuja el marcador de la ubicación actual del taxista.
    this._addMarker(
      MARKER_ID_INICIO,
      new PlaceItemRes(
        MARKER_ID_INICIO,
        'test',
        this.currentLatitud,
        this.currentLongitud
      )
    );
    ///------------------------------------------------------------------------
    /// Dibuja la línea desde el la ubicación actual hasta la de origen.
    this._checkDrawPolyline();
    ///------------------------------------------------------------------------
  }

  ///--------------------------------------------------------------------------
  /// Calcula la ubicación actual del taxista usando el GPS
  /// y se la manda al backend
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 26-05-2019
  void _actualizarUbicacion(){
    ///------------------------------------------------------------------------
    var ubicacion = new Location();
    ubicacion.onLocationChanged().listen((LocationData currentLocation) {
      this.currentLatitud = currentLocation.latitude;
      this.currentLongitud = currentLocation.longitude;
    });
    ///------------------------------------------------------------------------
    /// Envia al server la ubicación actual del taxista.
    _restService.actualizar(
        this.correoTaxista,
        this.currentLatitud,
        this.currentLongitud
    );
  }

  ///--------------------------------------------------------------------------
  /// Método que muestra la dirección de origen en caso de que el viaje
  /// haya sido insertado por un operador.
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 25-05-2019
  ///--------------------------------------------------------------------------
  _mostrarOrigenOperador(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TITULO_DIR_OPERADORA),
          content: Text(
            datosIniciales.origen.substring(1)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(COMENZAR_VIAJE_MENSAJE_BOTON),
              onPressed: () {
                this._comenzarViaje();
              },
            )
          ],
        );
      },
    );
  }
  ///--------------------------------------------------------------------------
}
///----------------------------------------------------------------------------