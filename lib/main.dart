import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/routes.dart';

import 'package:CoopeticoTaxiApp/util/seleccionador_home.dart';


void main() async{
  runApp(CoopeticoAppTaxista(await SeleccionadorHome.seleccionarHome()));
}


///
/// CoopeticoAppTaxista es el front end de la aplicación de CoopeTico para taxistas.
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