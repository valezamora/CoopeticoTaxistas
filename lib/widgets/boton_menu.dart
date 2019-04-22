import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';

/// Boton para ir al menú
///
/// Autor: Valeria Zamora
class BotonMenu extends StatelessWidget {
  RestService _restService = new RestService();
  String _correo;

  BotonMenu();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 60,
      child: IconButton(
        icon: Icon(Icons.menu),
        color: Paleta.Gris,
        iconSize: 25,
        alignment: Alignment.centerLeft,
        onPressed: () {
          obtenerDatos();
          Navigator.pushNamed(context, '/menu');
        },
      ),
    );
  }

  void obtenerDatos() async{
    bool hayDatos = await TokenService.existenDatosDeUsuario();
    if(!hayDatos) {
      _correo = await TokenService.getSub();
      String respuesta = await _restService.obtenerUsuario(_correo);
      print(respuesta);
      TokenService.guardarDatosUsuario(respuesta);
    }
    // Navigator.of(context).pushReplacementNamed('/menu'); //Redireccionar al menu.
  }
}