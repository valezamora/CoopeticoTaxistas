import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';

/// Clase que muestra los datos personales del usuario.
///
/// Autor: Valeria Zamora
class InfoUsuario extends StatelessWidget {
  final String nombre;
  final String correo;
  final String telefono;
  InfoUsuario(this.correo, this.nombre, this.telefono);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: new EdgeInsets.only(left: 20.0),
            child: Text('Nombre', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
          )
        ),
        SizedBox(
            width: double.infinity,
            child: Container(
              padding: new EdgeInsets.only(left: 35.0, top: 10.0),
              child: Text(this.nombre, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
            )
        ),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: new EdgeInsets.only(left: 20.0),
            child: Text('Teléfono', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
          )
        ),
        SizedBox(
            width: double.infinity,
            child: Container(
              padding: new EdgeInsets.only(left: 35.0, top: 10.0),
              child: Text(this.telefono, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
            )
        ),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: new EdgeInsets.only(left: 20.0),
            child: Text('Correo', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
          )
        ),
        SizedBox(
            width: double.infinity,
            child: Container(
              padding: new EdgeInsets.only(left: 35.0, top: 10.0),
              child: Text(this.correo, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal, color: Paleta.Gris, fontSize: TamanoLetra.H2)),
            )
        ),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
      ],
    );
  }
}