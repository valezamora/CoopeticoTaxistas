
import 'package:CoopeticoTaxiApp/models/payment_item.dart';

class PaymentUtils {
  static List<PaymentItem> payments;

  static List<PaymentItem> getPayments() {
    if(payments != null) {
      return payments;
    }

    payments = new List();
    payments.add(PaymentItem("Efectivo", "money.png"));
    payments.add(PaymentItem("Tarjeta de Crédito", "creditcard.png"));
    payments.add(PaymentItem("American Express", "american-express.png"));

    return payments;
  }
}