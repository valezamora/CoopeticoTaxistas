import 'dart:async';
import 'dart:convert';

import 'package:CoopeticoTaxiApp/services/network_service.dart';
import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';


/// Autor: Marco Venegas.
/// Clase para la comunicación con el backend mediante el REST API.
class RestService {
  NetworkService _networkService = new NetworkService();
  static const URL_BACKEND = "http://18.220.131.173:8080";  // 10.0.2.2 es para el emulador de android
  static const URL_LOGIN = URL_BACKEND + "/auth/signin";
  static const URL_OBTENER_USUARIO = URL_BACKEND + "/clientes/obtenerUsuario/";
  static const URL_TAXISTAS = URL_BACKEND + "/taxistas";
  static const URL_SIGNUP = URL_BACKEND + "/clientes";
  static const URL_EDITAR = URL_BACKEND + "/clientes/editar";
  static const URL_VIAJES = URL_BACKEND + "/viajes";
  static const URL_MONTOVIAJE = URL_VIAJES + "/costoViaje";
  static const URL_ACTUALIZAR_UBICACION = URL_BACKEND + "/ubicaciones/actualizar/ubicacion";

  /// Este método envía un POST al backend con un JSON en el cuerpo del request.
  ///
  /// Genera un Exception si se recibe algo que no es un JWT.
  /// Autor: Marco Venegas
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
      var resultado = "error";

      if (statusCode == 200) { //Se obtuvo el token satisfactoriamente.
        resultado = res.body;
        print(resultado);
      } else if (statusCode == 401){
        resultado = "noauth";
      }
      return resultado;
    });
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

  /// Este método envía un GET al backend con el correo del taxista que se desea consultar su estado.
  ///
  /// Recibe en el cuerpo de la respuesta un booleano que indica si está suspendido.
  /// Retorna un MAP con los datos del usuario como JSON.
  ///
  /// Autor: Marco Venegas
  Future<String> obtenerEstadoTaxista(String correo) {
    String url = URL_TAXISTAS + "/" + correo + "/estado";
    return _networkService.httpGet(url)
        .then((dynamic res) {
      var respuesta = res;
      // recibe srtring con un json
      return respuesta.body;
    });
  }

  /// Envía el JSON hacia el server para insertar los datos del
  /// viaje en creación
  ///
  /// Autor: Joseph Rementería (b55824).
  /// Fecha: 19-05-2019
  Future<String> crearViaje(
    String placa,
    String correoTaxista,
    String fechaInicio,
    String origen,
    String destino,
    String correoCliente
  ) {
    /// Creación del "header" del "request"
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    /// Creación del cuerpo del "request"
    String body = jsonEncode(
        {
          "placa"         : placa,
          "correoTaxista" : correoTaxista,
          "fechaInicio"   : fechaInicio,
          "origen"        : origen,
          "destino"       : destino,
          "correoCliente" : correoCliente
        }
    );
    return _networkService.httpPost(
      URL_VIAJES,
      body: body,
        header: header
      ).then((dynamic res) {
        //final String respuesta = res.body;
        final int codigo = res.statusCode;

        String resultado = "error";

        switch (codigo) {
          case 200:
            resultado = "ok";
            break;
        }
        return resultado;
      ///----------------------------------------------------------------------
      }
    );
  }

  /// Envía el JSON hacia el server para actualizar la ubicion
  ///
  /// Autor: Joseph Rementería (b55824).
  /// Fecha: 19-05-2019
  Future<String> actualizar(
      String correoTaxista,
      double lat,
      double lon
    ) {
    /// Creación del "header" del "request"
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    /// Creación del cuerpo del "request"
    String body = jsonEncode(
        {
          "correoTaxista" : correoTaxista,
          "latitud"       : lat,
          "longitud"      : lon
        }
    );
    return _networkService.httpPost(
        URL_ACTUALIZAR_UBICACION,
        body: body,
        header: header
    ).then((dynamic res) {
      ///----------------------------------------------------------------------
      //final String respuesta = res.body;
      final int codigo = res.statusCode;

      String resultado = "error";

      switch (codigo) {
        case 200:
          resultado = "ok";
          break;
      }
      return resultado;
      ///----------------------------------------------------------------------
    }
    );
  }

  /// Envia la respuesta a una solicitud de viaje
  ///
  /// Autor: Valeria Zamora
  respuestaViaje (bool respuesta, ViajeComenzando datos) async{
    String urlRespuesta = URL_VIAJES +  '/aceptar-rechazar?respuesta=' + respuesta.toString();
    String body = jsonEncode({
      "correoCliente": datos.correoCliente,
      "origen": datos.origen,
      "destino": datos.destino,
      "datafono": datos.datafono,
      "tipo": datos.tipo,
      "taxistasQueRechazaron": datos.taxistasQueRechazaron
    });
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json",
      "authorization": "Bearer " + await TokenService.getToken()
    };
    _networkService.httpPost(urlRespuesta, body: body, header: header).then((dynamic res) {
      final int codigo = res.statusCode;

      String resultado = res.body;

      switch (codigo) {
        case 200:
          resultado = "ok";
          break;
      }
      print(resultado);
      return resultado;
    }
    );
  }

  /// Finaliza un viaje, utilizando la [placa] y [fechaInicio], 
  /// además es necesario la [fechaFin] para finalizar el viaje.
  /// 
  /// Autor: Kevin Jiménez
  Future<String> finalizarViaje({String placa, String fechaInicio, String fechaFin}){
    String url = URL_VIAJES + "/finalizar";
    String body = jsonEncode({
      "placa": placa,
      "fechaInicio": fechaInicio,
      "fechaFin": fechaFin,
    });
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    return _networkService.httpPut(url, body: body, header: header)
        .then((dynamic res) {
      var respuesta = res;
      // recibe srtring con un json
      return respuesta.statusCode;
    });
  }

  /// Método envía en un PUT el monto que fue cobrado al cliente por el viaje.
  /// Autor: Marco Venegas.
  Future<List> enviarMonto(String placaTaxi, String fechaInicio, int monto) {
    String body = jsonEncode({"pkPlacaTaxi": placaTaxi, "pkFechaInicio": fechaInicio});

    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    String url = URL_MONTOVIAJE + "/" + monto.toString() + "/";

    return _networkService
        .httpPut(url, body: body, header: header)
        .then((dynamic res) {
      final int statusCode = res.statusCode;
      final String body = res.body;
      List respuesta = [statusCode, body];
      return respuesta;
    });
  }
  ///--------------------------------------------------------------------------
  Future<String> enviarPlaca(String correo, String placa) {
    ///------------------------------------------------------------------------
    /// Creación del "header" del "request"
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    ///------------------------------------------------------------------------
    return _networkService.httpPost(
        URL_TAXISTAS,
        header: header
    ).then((dynamic res) {
      ///----------------------------------------------------------------------
      //final String respuesta = res.body;
      final int codigo = res.statusCode;

      String resultado = "error";

      switch (codigo) {
        case 200:
          resultado = "ok";
          break;
      }
      return resultado;

      ///----------------------------------------------------------------------
    });
  }
  ///--------------------------------------------------------------------------
}
