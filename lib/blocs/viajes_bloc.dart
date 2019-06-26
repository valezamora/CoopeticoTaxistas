import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';
import 'package:CoopeticoTaxiApp/widgets/recibe_viaje.dart';

class ViajesBloc {

 // ViajeComenzando _viaje;

  WebSocketsService ws =  WebSocketsService();
  Stream viajeStream;

  static final ViajesBloc _bloc = new ViajesBloc._internal();
  factory ViajesBloc(){
    return _bloc;
  }
  ViajesBloc._internal();



  void connectStream() {
    ws.connect();
    viajeStream = ws.subscribe('/user/queue/recibir-viaje').stream;
    viajeStream.listen((data) => recibeViaje(data));
  }

  void dispose() {
    ws.unsubscribe('/user/queue/recibir-viaje');
    //subscription.cancel();
    //streamControllerViaje.close();
  }

  recibeDatos(data) {
    print(data);
   /* _viaje = new ViajeComenzando(
        data['correoCliente'],
        data['origen'],
        data['destino'],
        data['tipo'],
        data['datafono'],
        data['taxistasQueRechazaron']
    );*/
  }

  /// Metodo que muestra la alerta del viaje recibido
  /// Autor: Valeria Zamora
  void recibeViaje(data){
    print(data);
    // Map<String, dynamic> viajeInfo = jsonDecode(data);
    // var viaje = data.content;
    // print(viaje);
    // RecibeViaje.mostrarAlerta(context, viaje);
  }
}