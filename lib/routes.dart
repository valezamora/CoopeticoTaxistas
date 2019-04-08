//Importar cada ventana por separado.

import 'package:flutter/material.dart';
import 'package:CoopeticoApp/screens/login_usuario.dart';
import 'package:CoopeticoApp/screens/home.dart';

//import 'package:CoopeticoApp/screens/home.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginUsuario(),
  '/home':         (BuildContext context) => new Home(),
};