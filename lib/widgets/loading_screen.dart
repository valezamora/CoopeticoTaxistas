import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/widgets/taxis_loader.dart';
import 'package:CoopeticoTaxiApp/widgets/rotating_taxi_loader.dart';

/// Autor: Marco Venegas.
///Widget de un Loading Screen reutilizable.
///Oscurece el fondo y tiene una bolita de loading.
class LoadingScreen {

  void mostrar(BuildContext context){
    showDialog(
      barrierDismissible: false, //No se puede quitar presionando afuera.
      context: context,
      builder: (BuildContext context){
        return Container(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            child: Center(
                child: Container(
                  child: _seleccionar(),
                )
            ),
        );
      },
    );
  }

  void quitar(BuildContext context){
    Navigator.of(context).pop();
  }

  Widget _seleccionar(){
    Random random = new Random();
    bool aleatorio = random.nextBool();
    if(aleatorio){
      return new TaxisLoader();
    }else{
      return new RotatingTaxiLoader();
    }
  }
}