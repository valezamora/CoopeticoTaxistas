import 'package:flutter/material.dart';

/// Autor: Valeria Zamora

class FlechaAtras extends StatelessWidget {
  final Color color;
  FlechaAtras(this.color);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        color: this.color,
        iconSize: 40,
        onPressed: () {Navigator.pop(context);},
      ),
    );
  }
}
