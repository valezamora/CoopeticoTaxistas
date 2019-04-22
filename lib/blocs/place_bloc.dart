import 'dart:async';

import 'package:CoopeticoTaxiApp/services/google_maps_places.dart';
/// Bloc (Business Logic Component) de los Places
/// Se encarga de stremear los datos de los lugares, obtener el método de pago seleccionado
///
/// Autor: Paulo Barrantes

class PlaceBloc {
  var _placeController = StreamController();
  Stream get placeStream => _placeController.stream;


  /// Método para buscar lugares utilizando una palabra clave
  /// No devuelve nada, lo que en realidad hace es stremear los datos para así
  /// mostrarlos cuando ya estén listos.
  ///
  /// Autor: Paulo Barrantes

  void searchPlace(String keyword) {
    print("place bloc search: " + keyword);

    _placeController.sink.add("start");

    PlaceService.searchPlace(keyword).then((rs) {
      _placeController.sink.add(rs);
    }).catchError(() {
//      _placeController.sink.add("stop");
    });
  }

  void dispose() {
    _placeController.close();
  }
}
