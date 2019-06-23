import 'dart:async';
import 'dart:collection';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';
import 'package:CoopeticoTaxiApp/widgets/recibe_viaje.dart';

class ViajesBloc {

 // ViajeComenzando _viaje;

  StreamController<HashMap> streamControllerViaje;
  Stream<HashMap> viajeStream;
  StreamSubscription subscription;

  static final ViajesBloc _bloc = new ViajesBloc._internal();
  factory ViajesBloc(){
    return _bloc;
  }
  ViajesBloc._internal();



  void connectStream() {
    WebSocketsService().connect();
    streamControllerViaje = WebSocketsService().subscribe('/user/queue/recibir-viaje');
    viajeStream = streamControllerViaje.stream;
    subscription = viajeStream.listen(print);
  }

  void dispose() {
    subscription.cancel();
    streamControllerViaje.close();
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