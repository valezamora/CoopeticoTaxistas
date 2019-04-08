import 'package:flutter/material.dart';

//Entradas diseñadas para meterlas en un formulario y validar su contenido.
class EntradaTexto extends StatelessWidget {
  final String texto;
  final bool obscuredText;
  final validator;

  EntradaTexto(this.texto, this.obscuredText, {@required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0), //Padding solo en la parte de arriba
        child: SizedBox(
            width: 200.0,
            height: 30.0,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: '$texto'
              ),
              obscureText: obscuredText,
              validator: validator
            )));
  }
}
