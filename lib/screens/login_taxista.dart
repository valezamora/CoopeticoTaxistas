import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';

import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/services/web_sockets_service.dart';

import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/widgets/logo_coopetico.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';
import 'package:CoopeticoTaxiApp/widgets/etiqueta.dart';
import 'package:CoopeticoTaxiApp/widgets/loading_screen.dart';

/// Autor: Marco Venegas.
/// Ventana Stateful de login de taxisa.
class LoginTaxista extends StatefulWidget {
  final String titulo;
  LoginTaxista({Key key, this.titulo}) : super(key: key);

  @override
  _LoginTaxistaState createState() => new _LoginTaxistaState();
}

/// Ventana Stateles de login de usuario.
///
/// Implementa:
///             - Validación de correo válido.
///             - Validación de contraseña válida.
///             - Autenticación de usuario contra el backend mediante REST.
class _LoginTaxistaState extends State<LoginTaxista> {
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
  static const String TITAPPEQUIVOCADA = "Aplicación equivocada";
  static const String APPEQUIVOCADA =
      "No puede ingresar a la aplicación de taxistas con "
      "credenciales registrados en otra aplicación de CoopeTico.\n"
      "Descargue la aplicación correspondiente o ingrese credenciales "
      "para la aplicación de taxistas.";
  static const String TITSUSPENDIDO = "Cuenta suspendida";
  static const String SUSPENDIDO = "Su cuenta se encuentra suspendida.\n"
  "Intente ingresar luego nuevamente.\n"
  "Motivo de la suspensión:\n";
  RestService _restService = new RestService();
  WebSocketsService ws = new WebSocketsService();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _correo =
      ""; //Se almacenan aquí las entradas de texto para validarlas al presionar el botón.
  String _contrasena = "";

  /// Definición de ventana Login Usuario
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ListView(children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(bottom: 30.0, top: 128.0),
                  child: LogoCoopetico()),
              Etiqueta("Taxistas", TamanoLetra.H2, FontWeight.bold),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      EntradaTexto("Correo", "Correo", false,
                          validator: (value) {
                        String error = ValidadorLexico.validarCorreo(value);
                        if (error == null) {
                          this._correo = value;
                        }
                        return error;
                      }),
                      EntradaTexto(
                        "Contraseña",
                        "Contraseña",
                        true,
                        validator: (value) {
                          String error =
                              ValidadorLexico.validarContrasena(value);
                          if (error == null) {
                            this._contrasena = value;
                          }
                          return error;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                        child: Boton(
                            "Iniciar sesión", Paleta.Naranja, Paleta.Blanco,
                            onPressed: () {
                          if (_formKey.currentState.validate()) {
                            validarTaxista();
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
                  Navigator.pushNamed(context, '/recuperarContrasena');
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  /// Este método envía el correo y contraseña al backend mediante un HTTP POST.
  /// Recibe la string 'error' si hubo algún problema enviando el pedido o recibiendo la respuesta.
  /// Recibe la string 'noauth' si el correo o contraseña introducidos son incorrectos.
  ///
  /// Si el correo y contraseña son correctos, recibe un token en una string JSON.
  /// Esta la almacena en el dispositivo.
  void validarTaxista() async {
    LoadingScreen loadingSC = LoadingScreen();
    loadingSC.mostrar(context);
    try {
      String respuesta = await _restService.login(_correo, _contrasena);
      loadingSC.quitar(context);
      if (respuesta == "error") {
        DialogoAlerta.mostrarAlerta(context, ERROR, ERRORAUTH, OK);
      } else if (respuesta == "noauth") {
        DialogoAlerta.mostrarAlerta(context, DATOSINCORRECTOS, BADLOGIN, OK);
      } else {
        print('GUARDAR TOKEN');
        String mensaje = await TokenService.guardarTokenLogin(respuesta);
        print(mensaje);

        if (mensaje != 'OK') {
          if(mensaje == 'AppEquivocada'){
            DialogoAlerta.mostrarAlerta(
                context, TITAPPEQUIVOCADA, APPEQUIVOCADA, OK);
          }else{
            DialogoAlerta.mostrarAlerta(
                context, TITSUSPENDIDO, SUSPENDIDO + mensaje, OK);
          }
        } else {
          ws.connect(); //Se conecta al hacer login exitoso
          Navigator.of(context)
              .pushReplacementNamed('/home'); //Redireccionar al home screen.
        }
      }
    } catch (e) {
      loadingSC.quitar(context);
      DialogoAlerta.mostrarAlerta(context, ERRORDECONECCION, ERRORCONN, OK);
    }
  }
}
