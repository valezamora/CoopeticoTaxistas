///----------------------------------------------------------------------------
/// Imports
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/widgets/logo_coopetico.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';
import 'package:CoopeticoTaxiApp/widgets/etiqueta.dart';
///----------------------------------------------------------------------------
/// Ventana statful para solicitar la placa en caso de que no exista
///
/// Autor: Joseph Rementería (b55824)
class SolicitarPlaca extends StatefulWidget {
  final String titulo;
  SolicitarPlaca({Key key, this.titulo}) : super(key: key);

  @override
  _SolicitarPlacaState createState() => new _SolicitarPlacaState();
}

/// Venta para solicitar la placa y guardarla en el token de preferencias
class _SolicitarPlacaState extends State<SolicitarPlaca> {
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

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _placa = "";

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
                child: LogoCoopetico()
              ),
              Etiqueta("Taxistas", TamanoLetra.H2, FontWeight.bold),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EntradaTexto(
                      "Correo",
                      "Correo",
                      false,
                      validator: (value) {
                        String error = ValidadorLexico.validarPlaca(value);
                        if (error == null) {
                          this._placa = value;
                        }
                        return error;
                      }
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                      child: Boton(
                          "Guardar Placa", Paleta.Naranja, Paleta.Blanco,
                          onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //validarTaxista();
                        }
                      }),
                    ),
                  ],
                )
              )
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
  /*
  void validarTaxista() async {
    try {
      String respuesta = 'nice';
      print('respuesta recibida: '+respuesta);
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
          ///------------------------------------------------------------------
          /// Obtención de la placa desde el token
          String placaTaxi = '\$';
          TokenService.getPlacaTaxi().then( (val) => setState(() {
            placaTaxi = val;
          }));
          ///------------------------------------------------------------------
          /// Se selecciona cuál pantalla dirigir, si la de home de una o
          /// la del solicitar la placa
          String siguientePagina = '';
          if (placaTaxi == null) {
            siguientePagina = '/solicitarPlaca';
          } else {
            siguientePagina = '/home';
          }
          ///------------------------------------------------------------------
          /// Redirecciona a la pantalla debida
          Navigator.of(context)
              .pushReplacementNamed(siguientePagina);
          ///------------------------------------------------------------------
        }
      }
    } catch (e) {
      DialogoAlerta.mostrarAlerta(context, ERRORDECONECCION, ERRORCONN, OK);
    }
  }*/
}
