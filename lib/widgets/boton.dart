import 'package:flutter/material.dart';
import '../util/tamano_letra.dart';

//Asegurarse que al implementarlo esté dentro de un scaffold para que no se le cambie el tamaño.
class Boton extends StatelessWidget {
  final String texto;
  final Color color;
  final onPressed; //Lo que sucede al ser presionado.
  Boton(this.texto, this.color, {@required this.onPressed}); //Si el onPressed se pasa nulo, el botón es gris y no es presionable.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 30,
      child: RaisedButton(
        child: Center(
          child: Text(
            '$texto',
            style: TextStyle(fontSize: TamanoLetra.H2),
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
