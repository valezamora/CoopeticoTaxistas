import 'dart:async';

import 'package:http/http.dart' show Client;

/// Autor: Marco Venegas.
/// Clase para realizar pedidos HTTP de tipo Get y Post.
class NetworkService {
  //La clase debe ser un singleton.
  static NetworkService _instance = new NetworkService.internal();
  NetworkService.internal();
  factory NetworkService() => _instance;

  //Client se utiliza para poder reemplazarlo al hacer mocking.
  Client http = new Client();

  /// [url] contiene la dirección a donde se realizará el request.
  Future<dynamic> httpGet(String url) {
    return http.get(url).then((response) {
      return response;
    });
  }

  /// [url] contiene la dirección a donde se realizará el request.
  Future<dynamic> httpPost(String url, {Map header, body, encoding}) {
    return http
        .post(url, body: body, headers: header, encoding: encoding)
        .then((response) {
      return response;
    });
  }

  /// [url] contiene la dirección a donde se realizará el request.
  Future<dynamic> httpdelete(String url) {
    return http.delete(url).then((response) {
      return response;
    });
  }

  void setClient(Client client){
    this.http = client;
  }

  /// Hace un put al backend
  /// Autor: Kevin Jiménez
  Future<dynamic> httput(String url, {Map header, body, encoding}){
    return http
        .put(url, body: body, headers: header, encoding: encoding)
        .then((response) {
      return response;
    });
  }
}
