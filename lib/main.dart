import 'package:CoopeticoTaxiApp/screens/direcci%C3%B3nOrigen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:CoopeticoTaxiApp/routes.dart';

import 'package:CoopeticoTaxiApp/util/seleccionador_home.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async{
  // channel: IOWebSocketChannel.connect('ws://echo.websocket.org');
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
    var channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    channel.sink.add('caca');
    print('PROTOCOL' + channel.toString());
    return MaterialApp(
      title: 'Coopetico Taxi App',
      theme: new ThemeData(primaryColor: Colors.white, fontFamily: "Roboto"),
      home: home,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}