import 'dart:collection';
import 'dart:async';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:stomp_client/stomp_client.dart';

/// Clase para conectarse a web sockets
/// Autor: Kevin Jiménez
class WebSocketsService {
  // Esta clase es un singleton

  static WebSocketsService _instance = new WebSocketsService.internal();
  WebSocketsService.internal();
  factory WebSocketsService() => _instance;

  static const URL_BACKEND = "ws://localhost:8080/ws-flutter";
  StompClient client = new StompClient(urlBackend: URL_BACKEND);

  /// Metodo para conectarse al web socket
  ///
  /// Solamente se llama una vez al abrirse el app si el usuario ya está loggeado
  /// o al hacer login exitoso.
  ///
  /// Autor: Valeria Zamora
  /// Modificado: Marco Venegas
  connect() async{
      String token = await TokenService.getToken();
      client.connectWithToken(token: token);
  }

  /// Metodo para desconectarse de un endpoint
  ///
  /// Autor: Valeria Zamora
  disconect() {
    client.disconnect();
  }

  /// Metodo para suscribirse al WS
  ///
  /// Valeria Zamora
  StreamController<HashMap> subscribe (String topic) {
    return client.subscribe(topic: topic);
  }

  /// Metodo para cerrar suscripcion
  ///
  /// Valeria Zamora
  unsubscribe(String topic) {
    client.unsubscribe(topic: topic);
  }

  send(String topic, String message){
    client.send(topic: topic, message: message);
  }
}