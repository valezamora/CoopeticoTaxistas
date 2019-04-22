import 'package:flutter/material.dart';

/// Autor: Marco Venegas.
/// Widget de entradas de texto reutilizables.
/// Son entradas de texto diseñadas para meterlas en un formulario y validar su contenido.
class EntradaTexto extends StatelessWidget {
  final String texto;
  final String label;
  final bool
      obscuredText; //Esto debe ser true si queremos censurar el contenido.
  final validator;

  EntradaTexto(this.texto, this.label, this.obscuredText,
      {@required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            top: 30.0), //Padding solo en la parte de arriba
        child: SizedBox(
            width: 200.0,
            height: 40.0,
            child: TextFormField(
                decoration:
                    InputDecoration(labelText: '$label', hintText: '$texto'),
                obscureText: obscuredText,
                validator: validator)));
  }
}
