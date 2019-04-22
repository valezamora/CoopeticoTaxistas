///----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/widgets/etiqueta.dart';
///----------------------------------------------------------------------------
/// Widget que tiene la misma
///
/// Autor: Joseph Rementería (b55824).
///----------------------------------------------------------------------------
class EntradaTextoEtiqueta extends StatelessWidget {
  final String texto;
  final String label;
  final bool
      obscuredText; //Esto debe ser true si queremos censurar el contenido.
  final double tamano;
  final FontWeight peso;
  final validator;

  EntradaTextoEtiqueta(
    this.texto,
    this.label,
    this.obscuredText,
    this.tamano,
    this.peso,
    {@required this.validator}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            top: 30.0), //Padding solo en la parte de arriba
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Etiqueta ('$label',this.tamano,this.peso),
            SizedBox(
                width: 200.0,
                height: 40.0,
                child: TextFormField (
                    decoration: InputDecoration(hintText: '$texto'),
                    obscureText: this.obscuredText,
                    validator: this.validator
                )
            ),
          ],
        )
    );
  }
}
