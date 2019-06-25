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

  static const URL_BACKEND = "ws://18.220.131.173:8080/ws-flutter";
  StompClient client = new StompClient(urlBackend: URL_BACKEND);

  /// Metodo para conectarse al web socket
  ///
  /// Autor: Valeria Zamora
  connect() {
    client.general.stream.listen((message) {
      // handling of the incoming messages
      print(message);
      //messageReceieved(message);
    }, onError: (error, StackTrace stackTrace) {
      // error handling
    }, onDone: () {
      // communication has been closed
    });
    client.connectWithToken(token: TokenService.getToken());
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
    /*client.subscribe(topic: topic).stream.listen((message) {
      // handling of the incoming messages
      print("Mensaje:");
      print(message.toString());
      //messageReceieved(message);
    }, onError: (error, StackTrace stackTrace) {
      // error handling
    }, onDone: () {
      // communication has been closed
    });
    */
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