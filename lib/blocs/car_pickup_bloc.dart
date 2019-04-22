
import 'dart:async';
import 'package:CoopeticoTaxiApp/util/car_utils.dart';
import 'package:CoopeticoTaxiApp/models/car_item.dart';


/// Bloc (Business Logic Component) del car picker
/// Se encarga de stremear los datos, obtener el carro seleccionado
///
/// Autor: Paulo Barrantes
class CarPickupBloc {
  var _pickupController = new StreamController();
  var carList = CarUtils.getCarList();
  get stream => _pickupController.stream;

  var currentSelected = 0;

  /// Método que se encarga de seleccionar un carro
  /// No retorna nada
  ///
  /// Autor: Paulo Barrantes
  void selectItem(int index) {
    currentSelected = index;
    _pickupController.sink.add(currentSelected);
  }

  /// Método que se encarga de verificar si el carro que enviamos por parametro
  /// está actualmente seleccionado.
  /// Retorna un booleano
  ///
  /// Autor: Paulo Barrantes

  bool isSelected(int index) {
    return index == currentSelected;
  }
  /// Método que se encarga de devolver el carro seleccionado actualmente
  /// Retorna un Car Item
  ///
  /// Autor: Paulo Barrantes
  CarItem getCurrentCar() {
    return carList.elementAt(currentSelected);
  }

  void dispose() {
    _pickupController.close();
  }
}