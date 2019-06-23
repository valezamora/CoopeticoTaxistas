import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:stomp_client/stomp_client.dart';

/// Clase para conectarse a web sockets
/// Autor: Kevin Jiménez
class WebSocketsService {
  // Esta clase es un singleton
  WebSocketsService._privateConstructor();
  static final WebSocketsService _instance = WebSocketsService._privateConstructor();

  factory WebSocketsService(){
    return _instance;
  }

  static const URL_BACKEND = "http://192.168.1.6:8080";
  StompClient client;
}