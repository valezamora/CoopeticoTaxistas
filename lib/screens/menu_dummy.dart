import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_ver_perfil.dart';

/// Pantalla botón de menú.
///
/// Autor: Valeria Zamora
class MenuDummy extends StatefulWidget {
  final String titulo;

  MenuDummy({Key key, this.titulo}) : super(key: key);

  @override
  _MenuDummyState createState() => new _MenuDummyState();
}

class _MenuDummyState extends State<MenuDummy> {
  String nombre = "";

  @override
  void initState(){
    super.initState();
    TokenService.getnombreCompleto().then((respuesta){
      setState(() {
        nombre = respuesta;
        print(nombre);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            BotonPerfilUsuario(nombre)
          ],
        )
    );
  }

}