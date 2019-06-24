import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';
import 'package:CoopeticoTaxiApp/widgets/recibe_viaje.dart';

class ViajesBloc {

 // ViajeComenzando _viaje;

  WebSocketsService ws =  WebSocketsService();

  static final ViajesBloc _bloc = new ViajesBloc._internal();
  factory ViajesBloc(){
    return _bloc;
  }
  ViajesBloc._internal();



  void connectStream() {
    ws.connect();
    ws.subscribe('/user/queue/recibir-viaje').stream.listen((message) {
      // handling of the incoming messages
      print("Mensaje:");
      print(message.toString());
      //messageReceieved(message);
    }, onError: (error, StackTrace stackTrace) {
      // error handling
    }, onDone: () {
      // communication has been closed
    });
    ws.send('/user/queue/recibir-viaje', "holas");
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
        data['taxistasQueRecjazaron']
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