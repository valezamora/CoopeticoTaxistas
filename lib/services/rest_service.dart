import 'dart:async';
import 'dart:convert';

import 'package:CoopeticoApp/services/network_service.dart';

/// Clase para la comunicación con el backend mediante el REST API.
class RestService {
  NetworkService _networkService = new NetworkService();
  static final URL_BACKEND = "http://localhost:8080";
  static final URL_LOGIN = URL_BACKEND + "/auth/signin";

  /// Este método envía un POST al backend con un JSON en el cuerpo del request.
  ///
  /// Genera un Exception si se recibe algo que no es un JWT.
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
        URL_LOGIN, body: body, header: header)
        .then((dynamic res) {
      String respuesta = res;

      if(respuesta != "error" && respuesta != "noauth"){ //Se obtuvo el token satisfactoriamente.
        var partes = respuesta.split('.');
        if (partes.length != 3) {
          throw Exception('Token inválido.');
        }
        respuesta = _decodificarToken(partes[1]); //Decodifica la parte que nos interesa del token.
      }
      return respuesta;
    });
  }

  /// Método decodifica un JWT que es una string codificada con Base64.
  /// [encriptado] recibe un string encriptado con Base64.
  ///
  /// Genera una Exception si se ingresa una string que no está encriptada con Base64.
  String _decodificarToken(String encriptado) {
    //"intermedio" pues se transforma el string antes de decriptarse.
    String intermedio = encriptado.replaceAll('-', '+').replaceAll('_', '/');

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