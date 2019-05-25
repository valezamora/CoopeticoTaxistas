///----------------------------------------------------------------------------
/// Imports
import 'dart:async';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
///----------------------------------------------------------------------------
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
///----------------------------------------------------------------------------
// Google Maps
import 'package:google_maps_flutter/google_maps_flutter.dart';
///----------------------------------------------------------------------------
//Widgets
import 'package:CoopeticoTaxiApp/widgets/home_widgets/drawer.dart';
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
  final viajeComenzando datosIniciales;
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
  static const LatLng _center = const LatLng(9.901589, -84.009813);
  GoogleMapController _mapController;
  RestService _restService = new RestService();
  String correoTaxista;
  viajeComenzando datosIniciales;
  ///--------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    TokenService.getnombreCompleto().then( (val) => setState(() {
      correoTaxista = val;
    }));
  }
  ///--------------------------------------------------------------------------
  /// Constructor del despliegue original
  _DireccionOrigenState (viajeComenzando datosIniciales) {
    this.datosIniciales = datosIniciales;
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
                zoom: 14.4746,
              ),
              myLocationEnabled: true,
            ),
            ///----------------------------------------------------------------
            /// Botón de comenzar viaje.
            Positioned(
              bottom: 50,
              child:  Boton(
                'Comenzar Viaje',
                Paleta.Verde,
                Paleta.Blanco,
                onPressed: () {this._comenzarViaje();}
                ///--------------------------------------------------------------
              ),
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
  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
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
  /// TODO: check how to use this method to mark the 'from' point.
  /// Método privado que se utiliza para agregar un marcador en el mapa de Google
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  void _addMarker(String mkId, PlaceItemRes place) async {
    // remove old
    _markers.remove(mkId);
    _mapController.clearMarkers();

    _markers[mkId] = Marker(
        mkId,
        MarkerOptions(
            position: LatLng(place.lat, place.lng),
            infoWindowText: InfoWindowText(place.name, place.address)));

    for (var m in _markers.values){
      await _mapController.addMarker(m.options);
    }
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza para mover la cámara a alguna dirección
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  void _moveCamera() {
    print("move camera: ");
    print(_markers);

    if (_markers.values.length > 1) {
      var fromLatLng = _markers["from_address"].options.position;
      var toLatLng = _markers["to_address"].options.position;

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
  void _checkDrawPolyline() {
    print(_markers);
//  remove old polyline
    _mapController.clearPolylines();

    if (_markers.length > 1) {
      var from = _markers["from_address"].options.position;
      var to = _markers["to_address"].options.position;
      PlaceService.getStep(
          from.latitude, from.longitude, to.latitude, to.longitude)
          .then((vl) {
        TripInfoRes infoRes = vl;
        /// TODO: delete this var
        //_tripDistance = infoRes.distance;
        setState(() {
        });
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths.add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }

        _mapController.addPolyline(PolylineOptions(
            points: paths, color: Color(0xFF21a6ff).value, width: 3));
      });
    }
  }
  ///--------------------------------------------------------------------------
  /// Método privado que se utiliza para eliminar un marcador.
  ///
  /// No retorna nada
  /// Autor: Paulo Barrantes
  void _clearMarker(bool fromAddress){
    var mkId = fromAddress ? "from_address" : "to_address";
    print(mkId);
    print(_markers[mkId]);
    _mapController.clearPolylines();
    setState(() {
      _mapController.markers.forEach((marker){
        if(marker == _markers[mkId]){
          _mapController.removeMarker(marker);
        }
      });
      // We clear the distance
      /// TODO: delete this var
      /// _tripDistance = 0;
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
    ///print(this.correoTaxista);
    this.correoTaxista = 'taxista1@taxista.com';
    /// TODO: get the correct format for the hour.
    var timestamp = DateTime.now().toString().split(' ');
    String fechaInicio = timestamp[0] + "T" + timestamp[1].split(".")[0];
    String origen = this.datosIniciales.origen;
    String  correoCliente = this.datosIniciales.correoCliente;
    ///------------------------------------------------------------------------
    String codigo = await _restService.crearViaje(
      placa,
      this.correoTaxista,
      fechaInicio,
      origen,
      correoCliente
    );
    print(codigo);
    ///------------------------------------------------------------------------
  }
  ///--------------------------------------------------------------------------
}
///----------------------------------------------------------------------------