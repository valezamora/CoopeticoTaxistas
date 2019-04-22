import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Widget de entradas de texto reutilizables.
/// Son entradas de texto diseñadas para meterlas en un formulario y validar su contenido.
class BarraSuperior extends StatelessWidget {
  final String texto;

  BarraSuperior(this.texto);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(this.texto),
        backgroundColor: Paleta.GrisClaro,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        )
    );
  }
}
