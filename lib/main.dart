import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';

import 'package:CoopeticoTaxiApp/routes.dart';
import 'package:CoopeticoTaxiApp/blocs/viajes_bloc.dart';

import 'package:CoopeticoTaxiApp/util/seleccionador_home.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:stream_channel/stream_channel.dart';



void main() async{
  runApp(CoopeticoAppTaxista(await SeleccionadorHome.seleccionarHome()));
}


///
/// CoopeticoAppTaxista es el front end de la aplicación de CoopeTico para taxistas.
///
class CoopeticoAppTaxista extends StatelessWidget {
  final Widget home;
  // final WebSocketChannel channel;

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