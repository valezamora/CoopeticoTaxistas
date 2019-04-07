import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoApp/widgets/widgets_lib.dart';
import 'package:CoopeticoApp/util/util_lib.dart';
import 'package:CoopeticoApp/services/network_service.dart';
import 'package:CoopeticoApp/services/rest_service.dart';

class LoginUsuario extends StatefulWidget {
  final String titulo;
  LoginUsuario({Key key, this.titulo}) : super(key: key);

  @override
  _LoginUsuarioState createState() => new _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final String regExpCorreo =
      r"^([a-zA-Z0-9_\-\.]+)\@([a-zA-Z0-9_\-]+)\.([a-zA-Z]{2,5})$";
  final String regExpContrasena = r"^[^(\-\-|\;|\—)]+$";

  String _correo = "";
  String _contrasena = "";
  String _token = "";

  RestService _restService = new RestService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: LogoCoopetico()),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EntradaTexto("Correo", validator: (value) {
                      return validarCorreo(value);
                    }),
                    EntradaTexto(
                      "Contraseña",
                      validator: (value) {
                        return validarContrasena(value);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                      child:
                          Boton("Iniciar sesión", Paleta.Naranja, Paleta.Blanco,
                              onPressed: () {
                        if (_formKey.currentState.validate()) {
                          validarUsuario();
                        }
                      }),
                    ),
                  ],
                )),
            BotonPlano(
              "Recuperar contraseña",
              Paleta.Gris,
              TamanoLetra.H3,
              onPressed: () {
                print("TO DO");
              },
            ),
            BotonPlano(
              "Crear una cuenta",
              Paleta.Gris,
              TamanoLetra.H3,
              onPressed: () {
                  print("TO DO");
              }
            ),
          ],
        ),
      ),
    );
  }

  String validarCorreo(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Por favor ingrese su correo.";
    } else {
      RegExp regExp = new RegExp(regExpCorreo);
      if (!regExp.hasMatch(value)) {
        mensajeError = "Correo inválido.";
      } else {
        this._correo = value;
        mensajeError = null;
      }
    }

    return mensajeError;
  }

  String validarContrasena(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Por favor ingrese su contraseña.";
    } else {
      RegExp regExp = new RegExp(regExpContrasena);
      if (!regExp.hasMatch(value)) {
        mensajeError = "Contraseña inválida.";
      } else {
        this._contrasena = value;
        mensajeError = null;
      }
    }
    return mensajeError;
  }

  void validarUsuario() async {
    try{
      String respuesta = await _restService.login(_correo, _contrasena);
      if(respuesta == "error"){
        print("error");
      }else if(respuesta == "noauth"){
        print("noauth");
      }else{
        print(respuesta);
      }
    }catch(e){
      print("Error desconocido");
    }

  }

}
