/// Documento de rutas de las ventanas.
///
/// Por cuestiones de seguridad se debe importar cada una de las ventanas por separado.

import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginTaxista(),
  '/home':         (BuildContext context) => new Home(),
};