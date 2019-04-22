import 'package:flutter/material.dart';

/// Autor: Valeria Zamora
class AgregarFoto extends StatelessWidget {
  final onPressed; //Lo que sucede al ser presionado.
  final Color color;
  AgregarFoto(this.color, {@required this.onPressed}); //Si el onPressed se pasa nulo, el botón es gris y no es presionable.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: IconButton(
        icon: Icon(Icons.add_a_photo),
        color: this.color,
        onPressed: onPressed,
        iconSize: 50,
      ),
    );
  }
}
