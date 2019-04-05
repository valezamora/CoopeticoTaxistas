import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets_lib.dart';
import '../util/util_lib.dart';

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
                      child: Boton("Iniciar sesión", Paleta.Naranja,
                          onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("Formato válido");
                        }
                      }),
                    ),
                  ],
                )),
            BotonPlano(
              "Recuperar contraseña",
              Paleta.Azul,
              TamanoLetra.H3,
              onPressed: () {
                print("TO DO");
              },
            ),
            Container(
                padding: const EdgeInsets.only(top: 15.0),
                child:
                    BotonPlano("Crear una cuenta", Paleta.Azul, TamanoLetra.H3,
                        onPressed: () {
                  print("TO DO");
                }))
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
        mensajeError = null;
      }
    }

    return mensajeError;
  }
}
