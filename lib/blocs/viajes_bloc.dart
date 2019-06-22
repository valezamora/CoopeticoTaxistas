import 'dart:async';
import 'dart:collection';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';

class ViajesBloc {

  static StreamController<HashMap> streamControllerViaje;
  Stream<HashMap> viajeStream;
  StreamSubscription subscription;

  void connectStream() {
    WebSocketsService().connect();
    streamControllerViaje = WebSocketsService().subscribe('/user/queue/recibir-viaje');
    viajeStream = streamControllerViaje.stream;
    subscription = viajeStream.listen((data) => print(data));
  }

  void dispose() {
    subscription.cancel();
    streamControllerViaje.close();
  }
}