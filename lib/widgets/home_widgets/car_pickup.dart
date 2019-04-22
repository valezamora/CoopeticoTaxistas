
import 'package:CoopeticoTaxiApp/blocs/car_pickup_bloc.dart';
import 'package:flutter/material.dart';


/// Widget para elegir el vehículo deseado y además mostrar la distancia entre el origen y el destino
///
/// Autor: Paulo Barrantes
class CarPickup extends StatefulWidget {

  final int distance;
  CarPickup(this.distance);

  @override
  _CarPickupState createState() => _CarPickupState();
}

class _CarPickupState extends State<CarPickup> {

  var carBloc = new CarPickupBloc();

  @override
  Widget build(BuildContext context) {


    if( widget.distance > 0 ) {


      return StreamBuilder(
          stream: carBloc.stream,
          builder: (context, snapshot){
          return Stack(
            children: <Widget>[
              Positioned(
                bottom: 110, right: 0, left: 0,
                child: Container(
                  constraints: BoxConstraints.expand(height: 95),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: ListView.builder(itemBuilder: (context, index) {
                    return FlatButton(
                      color: carBloc.isSelected(index) ? Colors.orange[200] : Colors.white,
                      onPressed: () {
                        carBloc.selectItem(index);
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
                              child: Text(carBloc.carList.elementAt(index).name, style: TextStyle(color: Colors.white, fontSize: 10),),
                              padding: EdgeInsets.all(2),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Image.asset(carBloc.carList.elementAt(index).assetsName),
                              ),
                            ),
                            //Text("\$" + carBloc.carList.elementAt(index).pricePerKM.toString(), style: TextStyle(color: Color(0xff606470), fontSize: 12),)
                          ],
                        ),
                      ),
                    );
                  }, itemCount: carBloc.carList.length, scrollDirection: Axis.horizontal,),
                ),
              ),
              Positioned(
                bottom: 48, right: 0, left: 0, height: 50,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Total (" + _getDistanceInfo() + "): ",
                        style: TextStyle(fontSize: 18, color: Colors.black),),
//                    Text("\$" + _getTotal().toString(), style: TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20
//                    ),)
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(onPressed: (){}, color: Colors.black,
                    child: Text("Confirmar", style: TextStyle(color: Colors.white, fontSize: 16),),),
                ),)
            ],
          );
        },
      );
    } else{
      return StreamBuilder(
          stream: carBloc.stream,
          builder: (context, snapshot){
            return Container();
          }
      );
    }

  }
  /// Método para parsear la distancia
  /// Retorna un string con la distancia
  ///
  ///
  /// Autor: Paulo Barrantes
  String _getDistanceInfo() {
    double distanceInKM = widget.distance / 1000;
    return distanceInKM.toStringAsFixed(1) + " km";
  }

}