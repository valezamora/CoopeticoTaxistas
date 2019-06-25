/// Autor: Marco Venegas.
///
/// Clase con métodos estáticos para seleccionar con cuál pantalla se inicia la aplicación.

import 'dart:convert';

import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/screens/direccion_orig.dart';
import 'package:flutter/widgets.dart';

import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';

import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

class SeleccionadorHome {

  /// Selecciona el widget con el que empieza la aplicación.
  ///
  /// Autor: Marco Venegas
  static Future<Widget> seleccionarHome() async {
    Widget home = new LoginTaxista(titulo: "Login Taxista");
    try{
      //Se setea cual va a ser el home screen.
      bool existeTokenValido = await TokenService.existeTokenValido();
      if (existeTokenValido) { //Si hay un token guardado
        bool estado = await _getEstado(); //Igual se revisa si no ha sido suspendido.
        if (estado) { //Si no está suspendido
          home = new Home();
        }else{
          TokenService.borrarToken(); //Se borra el token
        }
      }
    } catch (e){ //Si se cae obteniendo el estado de un taxista o algo, se obliga a hacer login nuevamente.
      TokenService.borrarToken(); //Se borra el token
    }
    return home;
  }

  static Future<bool> _getEstado() async {
    RestService restService = new RestService();
    String respuesta = await restService.obtenerEstadoTaxista(await TokenService.getSub());
    Map respuestaJSON = jsonDecode(respuesta);

    bool estadoT = respuestaJSON['estado'];

    return estadoT;
  }
}