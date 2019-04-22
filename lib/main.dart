import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/routes.dart';

import 'package:CoopeticoTaxiApp/services/token_service.dart';

import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

void main() async{
  Widget home = new LoginTaxista(titulo: "Login Taxista");
  //Se setea cual va a ser el home screen.
  bool existeTokenValido = await TokenService.existeTokenValido();
  if (existeTokenValido) {
    home = new Home();
  }

  runApp(CoopeticoAppTaxista(home));
}


///
/// CoopeticoAppUsuario es el front end de la aplicación de CoopeTico.
///
class CoopeticoAppTaxista extends StatelessWidget {
  final Widget home;

  CoopeticoAppTaxista(this.home);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coopetico Taxi App',
      theme: new ThemeData(primaryColor: Colors.white, fontFamily: "Roboto"),
      home: home,
      routes: routes,
      debugShowCheckedModeBanner: false,

    );
  }
}