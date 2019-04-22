import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Clase que muestra una categoría de datos.
/// [id] el nombre del campo que se muestra
/// [texto] el contenido asociado al id
///
/// Autor: Valeria Zamora
class TextoPerfil extends StatelessWidget {
  final String texto;
  final String id;

  TextoPerfil(this.id, this.texto);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Container(
              padding: new EdgeInsets.only(left: 20.0),
              child: Text(
                  id,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Paleta.Gris,
                      fontSize: TamanoLetra.H2
                  )
              ),
            )
        ),
        SizedBox(
            width: double.infinity,
            child: Container(
              padding: new EdgeInsets.only(left: 35.0, top: 10.0),
              child: Text(
                  texto,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Paleta.Gris,
                      fontSize: TamanoLetra.H2
                  )
              ),
            )
        ),
      ],
    );
  }
}