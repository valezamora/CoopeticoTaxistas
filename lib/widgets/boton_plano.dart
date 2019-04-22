import 'package:flutter/material.dart';

/// Autor: Marco Venegas.
/// Widget de Boton plano reutilizable, que es similar a un Hyperlink.
class BotonPlano extends StatelessWidget {
  final String texto;
  final Color color;
  final double tamano;
  final onPressed; //Lo que sucede al ser presionado.
  BotonPlano(this.texto, this.color, this.tamano, {@required this.onPressed});

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
