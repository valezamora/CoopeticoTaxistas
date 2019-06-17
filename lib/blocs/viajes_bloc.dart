import 'dart:async';
import 'dart:collection';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';

class ViajesBloc {

  static StreamController<HashMap> _streamControllerViaje = WebSocketsService().subscribe('/user/queue/recibir-viaje');
  Stream<HashMap> viajeStream = _streamControllerViaje.stream;


  void dispose() {
    _streamControllerViaje.close();
  }
}