import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/blocs/payment_method_bloc.dart';



/// Widget que contiene la elección del método de pago
///
/// Autor: Paulo Barrantes
class PaymentMethod extends StatefulWidget {
  final int distance;
  PaymentMethod(this.distance);
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  var paymentBloc = new PaymentMethodBloc();
  @override
  Widget build(BuildContext context) {
    if (widget.distance > 0) {
      return StreamBuilder(
          stream: paymentBloc.stream,
          builder: (context, snapshot){
            return Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 75),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: ListView.builder(itemBuilder: (context, index) {
                      return FlatButton(
                        color: paymentBloc.isSelected(index) ? Colors.orange[200] : Colors.white,
                        onPressed: () {
                          paymentBloc.selectItem(index);
                        },
                        child: Container(
                          constraints: BoxConstraints.expand(width: 95),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff323643),
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                ),
                                child: Text(paymentBloc.paymentList.elementAt(index).name, style: TextStyle(color: Colors.white, fontSize: 10),),
                                padding: EdgeInsets.all(2),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                child: Center(
                                  child: Image.asset(paymentBloc.paymentList.elementAt(index).assetsName),
                                ),
                              ),
                              //Text("\$" + carBloc.carList.elementAt(index).pricePerKM.toString(), style: TextStyle(color: Color(0xff606470), fontSize: 12),)
                            ],
                          ),
                        ),
                      );
                    }, itemCount: paymentBloc.paymentList.length, scrollDirection: Axis.horizontal,),
                  ),
                ]
            );
          }
      );
    }else {
      return StreamBuilder(
          stream: paymentBloc.stream,
          builder: (context, snapshot){
            return Container();
          }
      );

    }

  }
}
