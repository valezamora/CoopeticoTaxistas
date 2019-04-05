//Es como un hyperlink.
import 'package:flutter/material.dart';

class BotonPlano extends StatelessWidget {
  final String texto;
  final Color color;
  final double tamano;
  final onPressed; //Lo que sucede al ser presionado.
  BotonPlano(this.texto, this.color, this.tamano, {@required this.onPressed}); //Si el onPressed se pasa nulo, el botón es gris y no es presionable.

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        //child: Center(
          child: Text(
            '$texto',
            style: TextStyle(fontSize: tamano),
          ),
        //),
        textColor: color,
        onPressed: onPressed,
        clipBehavior: Clip.none,
      );
  }
}