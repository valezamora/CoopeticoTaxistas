/// Documento de rutas de las ventanas.
///
/// Por cuestiones de seguridad se debe importar cada una de las ventanas por separado.

import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';
import 'package:CoopeticoTaxiApp/screens/perfil_usuario.dart';
import 'package:CoopeticoTaxiApp/screens/menu_dummy.dart';
import 'package:CoopeticoTaxiApp/screens/registro_usuario.dart';
import 'package:CoopeticoTaxiApp/screens/inicio_dummy.dart';
import 'package:CoopeticoTaxiApp/screens/recuperar_contrasena.dart';
import 'package:CoopeticoTaxiApp/screens/ride_picker_screen.dart';
import 'package:CoopeticoTaxiApp/screens/editar_usuario.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginTaxista(),
  '/home':          (BuildContext context) => new Home(),
  '/perfil':        (BuildContext context) => new PerfilUsuario(),
  '/menu':          (BuildContext context) => new MenuDummy(),
  '/registro':      (BuildContext context) => new RegistroUsuario(),
  '/inicio':        (BuildContext context) => new InicioDummy(),
  '/recuperarContrasena': (BuildContext context) => new RecuperarContrasena(),
  '/editar':   (BuildContext context) => new EditarUsuario(),
};