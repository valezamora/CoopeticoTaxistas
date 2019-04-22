import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Autor: Marco Venegas.
///Widget de un Diálogo de Alerta reutilizable.
///Este díalogo oscurece el fondo de el contexto donde se encuentre.
class DialogoAlerta {

  ///Método hace que aparezca el diálogo de alerta.
  static void mostrarAlerta(BuildContext context, String titulo, String texto, String textoBoton) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(texto),
          actions: <Widget>[
            new FlatButton(
              child: new Text(textoBoton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Muestra un  ventana de alerta al usuario.
  ///
  /// Muestra un  ventana de alerta al usuario. Implementa [onPressed] como
  /// la accin que se ejecutar cuando se oprima el boton.
  ///
  /// Autor: Kevin Jimenez
  static void mostrarAlertaConAccion(BuildContext context, String titulo, String texto, String textoBoton, {@required onPressed}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(texto),
          actions: <Widget>[
            new FlatButton(
              child: new Text(textoBoton),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }


}
