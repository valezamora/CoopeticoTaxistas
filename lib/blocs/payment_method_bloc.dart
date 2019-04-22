
import 'dart:async';
import 'package:CoopeticoTaxiApp/util/payment_utils.dart';
import 'package:CoopeticoTaxiApp/models/payment_item.dart';
/// Bloc (Business Logic Component) del payment method
/// Se encarga de stremear los datos, obtener el método de pago seleccionado
///
/// Autor: Paulo Barrantes
class PaymentMethodBloc {
  var _paymentController = new StreamController();
  var paymentList = PaymentUtils.getPayments();
  get stream => _paymentController.stream;

  var currentSelected = 0;
  /// Método que se encarga de seleccionar un método de pago
  /// No retorna nada
  ///
  /// Autor: Paulo Barrantes
  void selectItem(int index) {
    currentSelected = index;
    _paymentController.sink.add(currentSelected);
  }

  /// Método que se encarga de verificar si el método de pago que enviamos por parametro
  /// está actualmente seleccionado.
  /// Retorna un booleano
  ///
  /// Autor: Paulo Barrantes
  bool isSelected(int index) {
    return index == currentSelected;
  }

  /// Método que se encarga de devolver el método de pago seleccionado actualmente
  /// Retorna un Payment Item
  ///
  /// Autor: Paulo Barrantes

  PaymentItem getCurrentCar() {
    return paymentList.elementAt(currentSelected);
  }

  void dispose() {
    _paymentController.close();
  }
}