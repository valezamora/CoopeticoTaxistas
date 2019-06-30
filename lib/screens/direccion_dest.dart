///----------------------------------------------------------------------------
/// Imports
import 'dart:async';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/loading_screen.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';
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
/// dirección de destino del viaje.
///
/// Autor: Joseph Rementería (b55824).
/// Fecha: 25-06-2019.
///----------------------------------------------------------------------------
///
class DireccionDestino extends StatefulWidget {
  //---------------------------------------------------------------------------
  // Los datos que se traen desde la pantalla anterior
  final ViajeComenzando datosIniciales;
  final String fechaInicio;
  //---------------------------------------------------------------------------
  DireccionDestino(this.datosIniciales, this.fechaInicio);
  //---------------------------------------------------------------------------
  @override
  _DireccionDestinoState createState() =>
      _DireccionDestinoState(datosIniciales, fechaInicio);
//---------------------------------------------------------------------------
}
///----------------------------------------------------------------------------
class _DireccionDestinoState extends State<DireccionDestino> {
  ///--------------------------------------------------------------------------
  /// Variables globales.
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, Marker> _markers = <String, Marker>{};
  /// Si el centro el San Diego, entonces hay un error al recibir la dir de org
  LatLng _center = LatLng(9.901589, -84.009813);
  GoogleMapController _mapController;
  RestService _restService = new RestService();
  String correoTaxista; ///= 'taxista1@taxista.com';
  ViajeComenzando datosIniciales;
  String fechaInicio;
  double destinoLatitud;
  double destinoLongitud;
  double currentLatitud;
  double currentLongitud;
  ///--------------------------------------------------------------------------
  /// Constantes
  final String MARKER_ID_INICIO = "current";
  final String MARKER_ID_FIN = "destino";
  final String FINALIZAR_VIAJE_MENSAJE_BOTON = 'Finalizar Viaje';
  final String TITULO_DIR_OPERADORA = 'Indicaciones';
  static const String ERROR = "Error";
  static const String OK = "OK";

  static const String EXITO = "¡Éxito!";
  static const String EXITOMONTO = "Monto guardado exitosamente.";
  static const String NUEVAMENTE = "\nPor favor, inténtelo nuevamente.";

  static const String ERRORMONTO = "Hubo un error tratando de ingresar el monto del viaje." + NUEVAMENTE;
  static const String VIAJE404 = "No se encontró el viaje en la base de datos.\n" +
      "Por favor contacte a un administrador.";

  final int REFRESHING_RATIO = 3;

  ///--------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    TokenService.getSub().then( (val) => setState(() {
      correoTaxista = val;
    }));
    if (datosIniciales.destino[0] != '\$') {
      Timer.periodic(Duration(seconds: REFRESHING_RATIO),
        (Timer t) => this._dibujarRuta(context));
    } else {
      WidgetsBinding.instance
        .addPostFrameCallback((_) => _mostrarDestinoOperador(context));
      Timer.periodic(Duration(seconds: REFRESHING_RATIO),
        (Timer t) => _actualizarUbicacion());
    }
  }
  ///--------------------------------------------------------------------------
  /// Constructor del despliegue original
  _DireccionDestinoState (ViajeComenzando datosIniciales, String fechaInicio) {
    this.datosIniciales = datosIniciales;
    this.fechaInicio = fechaInicio;
    if (datosIniciales.destino[0] != '\$'){
      var destinoArray = datosIniciales.destino.split(',');
      this.destinoLatitud = double.parse(destinoArray[0]);
      this.destinoLongitud = double.parse(destinoArray[1]);
      _center = LatLng(destinoLatitud,destinoLongitud);
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
                FINALIZAR_VIAJE_MENSAJE_BOTON,
                Paleta.Verde,
                Paleta.Blanco,
                onPressed: () {this._finalizarViaje();}
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
  /// Editado por: Joseph Rementería (b55824); Fecha: 25-06-2019
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
    // remove old
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
  /// Editador por: Joseph Rementería (b55824); Fecha: 25-06-2019.
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
  /// Editador por: Joseph Rementería (b55824); Fecha: 25-06-2019.
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
  /// Editador por: Joseph Rementería (b55824); Fecha: 25-06-2019.
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
  /// Envíá los datos necesarios al backend para finalizar un viaje y pasa a la
  /// pantalla para ingresar el monto final cobrado al cliente.
  ///
  /// Autor: Marco Venegas
  /// Fecha: 26-06-2019
  ///--------------------------------------------------------------------------
  Future _finalizarViaje() async {
    /// Acá se recopilian los datos para actualizar la tupla del viaje.
    /// TODO: la placa para este sprint no es algo que se pueda obtener.
    String placa = "AAA111";
    //FechaInicio está una variable global.
    var timestamp = DateTime.now().toString().split(' ');
    String fechaFin = timestamp[0] + " " + timestamp[1].split(".")[0];

    ///TODO AQUI VA EL CÓDIGO DE KEVIN QUE MANDA EL REQUEST AL BACKEND PARA FINALIZAR EL VIAJE
    _restService.finalizarViaje(placa: placa, fechaFin: fechaFin, fechaInicio: fechaInicio).then((value){
      print(value);
      DialogoAlerta.mostrarAlerta(context, "Exito", "Se ha finalizado el viaje correctamente", "Aceptar");
    });
    Navigator.pushNamed(context, '/home');
    mostrarDialogoMonto(context, placa, this.fechaInicio);
  }


  /// Método que muestra un diálogo con una entrada de texto que solicita que se ingrese el monto
  /// cobrado en el viaje recién finalizado.
  ///
  /// Autor: Marco Venegas
  void mostrarDialogoMonto(BuildContext context, String placaTaxi, String fechaInicio){
    String valueMonto = '';
    DialogoEntradaTexto.mostrarAlerta(
        context,
        "Confirmación del monto.",
        "Por favor ingrese el monto en colones cobrado al cliente.",
        "Monto",
        "Confirmar",
        validator: (value){
          String error = ValidadorLexico.validarMonto(value);
          if(error == null){
            valueMonto = value;
          }
          return error;
        },
        onPressed: () {
          enviarMonto(context, placaTaxi, fechaInicio, int.parse(valueMonto));
        },
        dismissable: true
    );
  }

  /// Método que envía al backend el monto cobrado al cliente para almacernarlo en
  /// los datos del viaje recién finalizado.
  ///
  /// Autor: Marco Venegas
  void enviarMonto(BuildContext context, String placaTaxi, String fechaInicio, int monto) async{
    LoadingScreen loadingSC = LoadingScreen();
    loadingSC.mostrar(context);
    try{
      List respuesta = await _restService.enviarMonto(placaTaxi, fechaInicio, monto);
      loadingSC.quitar(context);

      int statusCode = respuesta[0];
      String body = respuesta[1];

      if(statusCode == 200){
        Navigator.of(context).pop();
        DialogoAlerta.mostrarAlerta(context, EXITO, EXITOMONTO, OK);
      }else{
        if(statusCode == 500){ //Si sucede un error de parte del servidor se pide intentar de nuevo.
          DialogoAlerta.mostrarAlerta(context, ERROR, ERRORMONTO, OK);
        }else{
          Navigator.of(context).pop();
          DialogoAlerta.mostrarAlerta(context, ERROR, VIAJE404, OK); //Si no se encuentra el viaje en la bd se pide contactar a un admin.
        }
      }
    }catch(e){
      loadingSC.quitar(context);
      DialogoAlerta.mostrarAlerta(context, ERROR, ERRORMONTO, OK);
      this.dispose();
    }
  }

  ///--------------------------------------------------------------------------
  /// Dibuja la ruta y actualiza los puntos de dirección actual y dirección
  /// de destino.
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 26-06-2019
  void _dibujarRuta(BuildContext context) async {
    ///------------------------------------------------------------------------
    /// Dibuja el marcador de la ubicación de destino.
    this._addMarker(
      MARKER_ID_FIN,
      new PlaceItemRes(
          MARKER_ID_FIN,
          'test',
          this.destinoLatitud,
          this.destinoLongitud
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
    /// Dibuja la línea desde el la ubicación actual hasta la de destino.
    this._checkDrawPolyline();
    ///------------------------------------------------------------------------
  }

  ///--------------------------------------------------------------------------
  /// Calcula la ubicación actual del taxista usando el GPS
  /// y se la manda al backend
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 26-06-2019
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
  /// Método que muestra la dirección de destino en caso de que el viaje
  /// haya sido insertado por un operador.
  ///
  /// Autor: Joseph Rementería (b55824)
  /// Fecha: 26-06-2019
  ///--------------------------------------------------------------------------
  _mostrarDestinoOperador(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TITULO_DIR_OPERADORA),
          content: Text(
            datosIniciales.destino.substring(1)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(FINALIZAR_VIAJE_MENSAJE_BOTON),
              onPressed: () {
                this._finalizarViaje();
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