import 'package:flutter/material.dart';

class EntradaTexto extends StatelessWidget {
  final texto;

  EntradaTexto(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
            width: 200.0,
            height: 30.0,
            child: TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                  hintText: '$texto'),
            )));
  }
}
