import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';

/// Autor: Marco Venegas.
///Widget de un Diálogo de Alerta con entrada de texto reutilizable.
///Este díalogo oscurece el fondo de el contexto donde se encuentre.
class DialogoEntradaTexto {

  ///Método hace que aparezca el diálogo de alerta.
  static void mostrarAlerta(BuildContext context, String titulo, String texto, String hintEntrada, String textoBoton, {@required final validator, final onPressed, final dismissable}) {
    // flutter defined function
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    showDialog(
      barrierDismissible: dismissable, //No se puede quitar presionando afuera.
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(titulo),
          content: new Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(texto),
                new EntradaTexto(
                  hintEntrada,
                  hintEntrada,
                  false,
                  validator: validator,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(textoBoton),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
