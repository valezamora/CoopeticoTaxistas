import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoApp/util/paleta.dart';
import 'package:CoopeticoApp/util/tamano_letra.dart';

import 'package:CoopeticoApp/services/rest_service.dart';
import 'package:CoopeticoApp/services/token_service.dart';

import 'package:CoopeticoApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoApp/widgets/logo_coopetico.dart';
import 'package:CoopeticoApp/widgets/entrada_texto.dart';
import 'package:CoopeticoApp/widgets/boton.dart';
import 'package:CoopeticoApp/widgets/boton_plano.dart';

/// Ventana Stateful de login de usuario.
class LoginUsuario extends StatefulWidget {
  final String titulo;
  LoginUsuario({Key key, this.titulo}) : super(key: key);

  @override
  _LoginUsuarioState createState() => new _LoginUsuarioState();
}

/// Ventana Stateles de login de usuario.
///
/// Implementa:
///             - Validación de correo válido.
///             - Validación de contraseña válida.
///             - Autenticación de usuario contra el backend mediante REST.
class _LoginUsuarioState extends State<LoginUsuario> {
  static const String ERROR = "Error";
  static const String ERRORDECONECCION = "Error de conexión";
  static const String OK = "OK";
  static const String ERRORAUTH =
      "Hubo un error tratando de autenticar su cuenta.\n" +
          "Por favor, inténtelo de nuevo.";
  static const String ERRORCONN =
      "Hubo un error tratando de realizar la conexión.\n" +
          "Por favor, verifique su conexión a internet e inténtelo de nuevo.";
  static const String DATOSINCORRECTOS = "Datos incorrectos";
  static const String BADLOGIN =
      "El usuario o contraseña que ingresó es incorrecto.";

  RestService _restService = new RestService();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final String regExpCorreo =
      r"^([a-zA-Z0-9_\-\.]+)\@([a-zA-Z0-9_\-]+)\.([a-zA-Z]{2,5})$";
  final String regExpContrasena = r"^[^(\-\-|\;|\—)]+$";

  String _correo = ""; //Se almacenan aquí las entradas de texto para validarlas al presionar el botón.
  String _contrasena = "";

  /// Definición de ventana Login Usuario
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    EntradaTexto(
                      "Correo",
                      false,
                      validator: (value) {
                        return validarCorreo(value);
                      }
                    ),
                    EntradaTexto(
                      "Contraseña",
                      true,
                      validator: (value) {
                        return validarContrasena(value);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                      child: Boton(
                        "Iniciar sesión",
                        Paleta.Naranja,
                        Paleta.Blanco,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            validarUsuario();
                          }
                        }
                      ),
                    ),
                  ],
                )
            ),
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

  /// [value] contiene el correo al que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
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

  /// [value] contiene la contraseña a la que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  /// No se permiten contraseñas con '--' o ';'.
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

  /// Este método envía el correo y contraseña al backend mediante un HTTP POST.
  /// Recibe la string 'error' si hubo algún problema enviando el pedido o recibiendo la respuesta.
  /// Recibe la string 'noauth' si el correo o contraseña introducidos son incorrectos.
  ///
  /// Si el correo y contraseña son correctos, recibe un token en una string JSON.
  /// Esta la almacena en el dispositivo.
  void validarUsuario() async {
    try {
      String respuesta = await _restService.login(_correo, _contrasena);
      if (respuesta == "error") {
        DialogoAlerta.mostrarAlerta(context, ERROR, ERRORAUTH, OK);
      } else if (respuesta == "noauth") {
        DialogoAlerta.mostrarAlerta(context, DATOSINCORRECTOS, BADLOGIN, OK);
      } else {
        TokenService.guardarTokenLogin(respuesta);
        Navigator.of(context).pushReplacementNamed('/home'); //Redireccionar al home screen.
      }
    } catch (e) {
      DialogoAlerta.mostrarAlerta(context, ERRORDECONECCION, ERRORCONN, OK);
    }
  }
}
