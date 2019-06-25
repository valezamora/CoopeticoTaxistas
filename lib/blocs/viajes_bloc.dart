import 'dart:async';
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
    ws.subscribe("/queue/a");
    ws.send("/queue/a", "holas");
    viajeStream = ws.subscribe('/user/queue/recibir-viaje').stream;
  }

  void dispose() {
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
  void recibeViaje(context, data){
    print(data);
    var viaje = data.content;
    RecibeViaje.mostrarAlerta(context, viaje);
  }
}