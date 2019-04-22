import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';



/// Widget de un Diálogo de confirmación reutilizable.
/// Este díalogo oscurece el fondo de el contexto donde se encuentre.
///
/// Autor: Kevin Jimenez.
class DialogoConfirmacion {
  /// Método hace que aparezca el diálogo de alerta.
  /// 
  /// [onPressed] define la accion que se ejecutara cuando se oprima
  /// el boton de confimación. [textoBoton] define el texto del boton de accion
  /// 
  static void mostrarAlerta(
      BuildContext context, String titulo, String texto, {@required onPressed, @required textoBoton}) {
    // flutter defined function
    showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(texto),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(textoBoton),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
  }
}
