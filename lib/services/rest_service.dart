import 'dart:async';
import 'dart:convert';

import 'package:CoopeticoTaxiApp/services/network_service.dart';

/// Autor: Marco Venegas.
/// Clase para la comunicación con el backend mediante el REST API.
class RestService {
  NetworkService _networkService = new NetworkService();
  static const URL_BACKEND = "http://192.168.0.12:8080";  // 10.0.2.2 es para el emulador de android
  static const URL_LOGIN = URL_BACKEND + "/auth/signin";
  static const URL_OBTENER_USUARIO = URL_BACKEND + "/clientes/obtenerUsuario/";
  static const URL_SIGNUP = URL_BACKEND + "/clientes";
  static const URL_EDITAR = URL_BACKEND + "/clientes/editar";

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
      final String respuesta = res.body;
      final int statusCode = res.statusCode;

      String resultado = "error";

      if (statusCode == 200) { //Se obtuvo el token satisfactoriamente.
        var partes = respuesta.split('.');
        if (partes.length != 3) {
          throw Exception('Token inválido.');
        }
        resultado = _decodificarToken(
            partes[1]); //Decodifica la parte que nos interesa del token.
      } else if (statusCode == 401){
        resultado = "noauth";
      }
      return resultado;
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


  /// Este método envía un GET al backend con el correo del usuario que se desea consultar.
  ///
  /// Recibe en el cuerpo de la respuesta un string con los datos del usuario.
  /// Retorna un MAP con los datos del usuario como JSON.
  ///
  /// Autor: Valeria Zamora
  Future<String> obtenerUsuario(String correo) {
    String url = URL_OBTENER_USUARIO + correo;
    return _networkService.httpGet(url)
        .then((dynamic res) {
      var respuesta = res;
      // recibe srtring con un json
      return respuesta.body;
    });
  }

  /// Solicita un token para recuperar la contraseña del usuario.
  //
  /// Envia un get al backend con el [correo} al endpoint
  /// 'usuarios/contrasenaToken'.
  ///
  /// Autor: Kevin Jimenez
  Future<void> obtenerTokenRecuperacionContrasena(String correo){
    return _networkService.httpGet(URL_BACKEND + '/usuarios/contrasenaToken?correo=' + correo);
  }

  /// Envia un request al backend para borrar al usuario con [correo]
  /// 
  /// Autor: Kevin Jimenez
  void borrarUsuario(correo){
    _networkService.httpdelete(URL_BACKEND+ '/usuarios/' + correo);
  }
}
