import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_menu.dart';

/// Pantalla botón de menú.
///
/// Autor: Valeria Zamora
class InicioDummy extends StatefulWidget {
  final String titulo;

  InicioDummy({Key key, this.titulo}) : super(key: key);

  @override
  _InicioDummyState createState() => new _InicioDummyState();
}

class _InicioDummyState extends State<InicioDummy> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            BotonMenu()
          ],
        )
    );
  }

}