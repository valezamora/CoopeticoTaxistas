import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// Widget de pantalla para recibir viajes.
///
/// Autor: Valeria Zamora
class RecibirViaje extends StatefulWidget {
  @override
  _RecibirViaje createState() => new _RecibirViaje();
}

class _RecibirViaje extends State<RecibirViaje> {
  Timer _tiempo;
  int _inicio;

  @override
  Widget build(BuildContext context) {
    startTimer();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Viaje entrante'),
          content: Text('Quedan ' + _inicio.toString() + ' segundos.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Rechazar'),
              onPressed: () {
                // Enviar mensaje a BE de rechazo
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                // Enviar mensaje de BE de aceptacion
                // Guardar datos del viaje en ViajeComenzando.
              },
            ),
          ],
        );
      },
    );
  }

  void startTimer() {
    const segundo = const Duration(seconds:1);
    _tiempo = new Timer.periodic(segundo, (Timer tiempo) => (() {
      if(_inicio <= 0) {
        _tiempo.cancel();
      } else {
        _inicio -= 1;
      }
    }));
  }
}
