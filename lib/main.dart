import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/routes.dart';

import 'package:CoopeticoTaxiApp/services/token_service.dart';

import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

void main() => runApp(CoopeticoTaxiApp());

///
/// CoopeticoAppUsuario es el front end de la aplicación de CoopeTico.
///
class CoopeticoTaxiApp extends StatelessWidget {
  Widget home = new LoginTaxista(titulo: "Login Taxista");

  CoopeticoAppTaxista(){
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
      title: 'Coopetico Taxi App',
      theme: new ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Roboto"
      ),
      home: home,
      routes: routes,
    );
  }
}