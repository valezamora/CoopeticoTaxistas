import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';


import 'package:CoopeticoTaxiApp/services/rest_service.dart';

/// Widget de un Diálogo de confirmacion de viaje recibido.
/// Este díalogo oscurece el fondo de el contexto donde se encuentre.
///
/// Autor: Valeria Zamora
class RecibeViaje {

  static RestService _restService = new RestService();
  static int _inicio = 10;
  static const segundo = const Duration(seconds:1);

  /// Método hace que aparezca el diálogo de recibir viaje.
  ///
  /// Autor: Valeria Zamora
  static void mostrarAlerta(BuildContext context) {
    Timer _tiempo;
    // TODO fix timer
    _tiempo = new Timer.periodic(segundo, (Timer tiempo) => (() {
      if(_inicio <= 0) {    // no contesta en 10 segundos
        _tiempo.cancel();
        responder(context, false);
      } else {
        _inicio -= 1;
      }
    }));
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Viaje recibido'),
          content: Text('Ha recibido un viaje nuevo'),
          actions: <Widget>[
            FlatButton(
              child: Text('Rechazar'),
              onPressed: () {
                responder(context, false);
              },
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: _restService.respuestaViaje(true, null), // TODO send respuesta (datos viaje)
              // TODO cargar ruta hacia cliente
            ),
          ],
        );
      },
    );
  }

  static responder(context, bool respuesta) {
    _restService.respuestaViaje(respuesta, null); // TODO send respuesta (datos viaje)
    Navigator.of(context).pop();
  }
}
