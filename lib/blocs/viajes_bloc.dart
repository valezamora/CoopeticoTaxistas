import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

class ViajesBloc {

  ViajeComenzando viaje;
  WebSocketsService ws =  WebSocketsService();
  Stream viajeStream;
  String infoViajeString;

  static final ViajesBloc _bloc = new ViajesBloc._internal();
  factory ViajesBloc(){
    return _bloc;
  }
  ViajesBloc._internal();

  void connectStream() {
    ws.connect();
    viajeStream = ws.subscribe('/user/queue/recibir-viaje').stream;
    // viajeStream.listen((data) => recibeViaje(data));
  }

  void dispose() {
    ws.unsubscribe('/user/queue/recibir-viaje');
    //subscription.cancel();
    //streamControllerViaje.close();
  }

  /// Metodo que muestra la alerta del viaje recibido
  /// Autor: Valeria Zamora
  void recibeViaje(data){
    Map<String, dynamic> viajeInfo = new Map<String, dynamic>.from(data);
    infoViajeString = viajeInfo['content'];
    print(infoViajeString);
    Map<String, dynamic> viajeComenzando = jsonDecode(infoViajeString);
    viaje = new ViajeComenzando(
        viajeComenzando['correoCliente'],
        viajeComenzando['origen'],
        viajeComenzando['destino'],
        viajeComenzando['taxistasQueRechazaron']
    );
    print(viaje.correoCliente);
  }
}