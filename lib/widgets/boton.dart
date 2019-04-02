import 'package:flutter/material.dart';

//Asegurarse que al implementarlo esté dentro de un scaffold para que no se le cambie el tamaño.
class Boton extends StatelessWidget {
  final texto;
  final color;
  final onPressed; //Lo que sucede al ser presionado.
  Boton(this.texto, this.color, {@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 30,
      child: RaisedButton(
        child: Center(
          child: Text(
            '$texto',
            style: TextStyle(fontFamily: "Roboto", fontSize: 14.0),
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
