import 'package:flutter/material.dart';

import 'package:CoopeticoApp/util/tamano_letra.dart';

/// Widget de Botón reutilizable.
///
/// Hay que asegurarse de que el botón esté contenido dentro
/// de un Scaffold porque si no se le cambia el tamaño.
class Boton extends StatelessWidget {
  final String texto;
  final Color color;
  final Color colorTexto;
  final onPressed; //Lo que sucede al ser presionado.
  Boton(this.texto, this.color, this.colorTexto, {@required this.onPressed}); //Si el onPressed se pasa nulo, el botón es gris y no es presionable.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 30,
      child: RaisedButton(
        child: Center(
          child: Text(
            '$texto',
            style: TextStyle(fontSize: TamanoLetra.H2, color: colorTexto),
          ),
        ),
        color: color,
        elevation: 4.0,
        //splashColor: Colors.blueGrey,
        onPressed: onPressed,
      ),
    );
  }
}
