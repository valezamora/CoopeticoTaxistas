import 'dart:async';
import 'dart:convert';

import 'package:CoopeticoApp/services/network_service.dart';

class RestService {
  NetworkService _networkService = new NetworkService();
  static final URL_BASE = "http://localhost:8080";
  static final URL_LOGIN = URL_BASE + "/auth/signin";

  Future<String> login(String correo, String contrasena) {
    String body = jsonEncode(
        {
          "username": correo,
          "password": contrasena
        }
    );

    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    return _networkService.httpPost(
        "http://localhost:8080/auth/signin/", body: body, header: header)
        .then((dynamic res) {
      String respuesta = "";
      if(res == "error"){
        respuesta = "error";
      }else if(res == "noauth"){
        respuesta = "noauth";
      }else{ //Se obtuvo el token satisfactoriamente.
        var partes = res.split('.');
        if (partes.length != 3) {
          throw Exception('Token inválido.');
        }
        respuesta = _decodificarToken(partes[1]);
      }
      return respuesta;
    });
  }

  String _decodificarToken(String encriptado) {
    String intermedio = encriptado.replaceAll('-', '+').replaceAll('_', '/'); //"intermedio" pues se transforma el string antes de decriptarse.

    switch (intermedio.length % 4) {
      case 0:
        break;
      case 2:
        intermedio += '==';
        break;
      case 3:
        intermedio += '=';
        break;
      default:
        throw Exception('No es una string Base64!"');
    }

    String decriptado = utf8.decode(base64Url.decode(intermedio));
    return decriptado;
  }
}