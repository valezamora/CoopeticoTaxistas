import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/widgets/flecha_atras.dart';
import 'package:CoopeticoTaxiApp/widgets/foto_usuario.dart';
import 'package:CoopeticoTaxiApp/widgets/info_usuario.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';

/// Pantalla que muestra el perfil del taxista.
///
/// Autor: Valeria Zamora
class PerfilUsuario extends StatefulWidget {
  final String titulo;

  PerfilUsuario({Key key, this.titulo}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => new _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  String nombre = '';
  String telefono = '';
  String correo = '';
  String fotoURL = '';

  @override
  void initState(){
    super.initState();
    TokenService.getnombreCompleto().then((respuesta){
      setState(() {
        nombre = respuesta;
      });
    });
    TokenService.getTelefono().then((respuesta) {
      setState(() {
        telefono = respuesta;
      });
    });

    TokenService.getSub().then((respuesta) {
      setState(() {
        correo = respuesta;
      });
    });
    TokenService.getFotoUrl().then((respuesta) {
      setState(() {
        fotoURL = respuesta;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: FlechaAtras(Paleta.Blanco),
            title: Text(nombre, style: TextStyle(color: Paleta.Blanco)),
            centerTitle: true,
            backgroundColor: Paleta.Gris,
            iconTheme: IconThemeData(color: Paleta.Blanco)
        ),
        body: ListView(
          children: <Widget>[
            FotoUsuario(fotoURL),
            InfoUsuario(correo, nombre, telefono),
          ],
        )
    );
  }
}