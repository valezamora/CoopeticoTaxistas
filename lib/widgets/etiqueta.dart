import 'package:flutter/widgets.dart';

/// Widget de etiqueta de texto reutilizable.
class Etiqueta extends StatelessWidget {
  final String texto;
  final double tamano;
  final FontWeight peso; //normal o bold.

  Etiqueta(this.texto, this.tamano, this.peso);

  @override
  Widget build(BuildContext context){
    return Text(
        '$texto',
        style: TextStyle(
            fontSize: tamano,
            fontWeight: peso
        )
    );
  }
}