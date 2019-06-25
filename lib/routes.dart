import 'package:CoopeticoTaxiApp/models/viaje_comenzando.dart';
import 'package:CoopeticoTaxiApp/screens/direccion_orig.dart';
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
  '/recuperarContrasena': (BuildContext context) => new RecuperarContrasena(),z
  '/recibirViaje': (BuildContext context) => new RecibirViaje(),
};