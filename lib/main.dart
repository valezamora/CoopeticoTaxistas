import 'package:flutter/material.dart';

import 'package:CoopeticoApp/routes.dart';

import 'package:CoopeticoApp/services/token_service.dart';

import 'package:CoopeticoApp/screens/login_usuario.dart';
import 'package:CoopeticoApp/screens/home.dart';

void main() => runApp(CoopeticoAppUsuario());

///
/// CoopeticoAppUsuario es el front end de la aplicación de CoopeTico.
///
class CoopeticoAppUsuario extends StatelessWidget {
  Widget home = new LoginUsuario(titulo: "Login Usuario");

  CoopeticoAppUsuario(){
    _setHome();
  }

  void _setHome() async{
    bool existeTokenValido = await TokenService.existeTokenValido();
    if(existeTokenValido){
      home = new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coopetico App',
      theme: new ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Roboto"
      ),
      home: home,
      routes: routes,
    );
  }
}