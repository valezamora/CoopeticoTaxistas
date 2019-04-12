import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Autor: Marco Venegas.
/// Clase para realizar pedidos HTTP de tipo Get y Post.
class NetworkService {
  //La clase debe ser un singleton.
  static NetworkService _instance = new NetworkService.internal();
  NetworkService.internal();
  factory NetworkService() => _instance;

  /// [url] contiene la dirección a donde se realizará el request.
  Future<dynamic> httpGet(String url) {
    return http.get(url).then((http.Response response) {
      /*
      final String res = response.body; //Se almacena la respuesta del get.
      final int statusCode = response.statusCode;
      String respuesta = "error";
      if(json != null){
        if(statusCode == 403){
          respuesta = "noauth";
        }else if(statusCode == 200){
          respuesta = res; //En éxito se devuelve el body.
        }
      }
      */
      return response;
    });
  }

  /// [url] contiene la dirección a donde se realizará el request.
  Future<dynamic> httpPost(String url, {Map header, body, encoding}) {
    return http
        .post(url, body: body, headers: header, encoding: encoding)
        .then((http.Response response) {
      /*
      final String res = response.body;
      final int statusCode = response.statusCode;

      String respuesta = "error";
      if(json != null){
        if(statusCode == 403){
          respuesta = "noauth";
        }else if(statusCode == 200){
          respuesta = res; //En éxito se devuelve el body.
        }
      }
      */
      return response;
    });
  }
}