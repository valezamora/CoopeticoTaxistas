import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/screens/direcci%C3%B3nOrigen.dart';
/// Documento de rutas de las ventanas.
///
/// Por cuestiones de seguridad se debe importar cada una de las ventanas por separado.

import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';
import 'package:CoopeticoTaxiApp/screens/perfil_usuario.dart';
import 'package:CoopeticoTaxiApp/screens/recuperar_contrasena.dart';
import 'package:CoopeticoTaxiApp/widgets/recibir_viaje.dart';

final routes = {
  '/login'              : (BuildContext context) => new LoginTaxista(),
  '/home'               : (BuildContext context) => new Home(),
  '/perfil'             : (BuildContext context) => new PerfilUsuario(),
  '/recuperarContrasena': (BuildContext context) => new RecuperarContrasena(),
  '/direccionOrigen'    : (BuildContext context)
    /// TODO: get the name ot the class.
    => new DireccionOrigen(
        new ViajeComenzando(
          "cliente@cliente.com",
          "9.9555117,-84.1153095",
          ///"\$Mall San Pedro, entrada principal",
          null, null, null, null
        )
      ),
  '/recibirViaje': (BuildContext context) => new RecibirViaje(),
};