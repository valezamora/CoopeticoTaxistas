///----------------------------------------------------------------------------
/// sección de imports
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto_etiqueta.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_eliminar_cuenta.dart';
import 'package:CoopeticoTaxiApp/routes.dart';

///----------------------------------------------------------------------------
/// Inicio  de la clase stateful
/// Ventana Stateful de Editar de usuario.
///
/// Autor: Joseph Rementería (b55824)
class EditarUsuario extends StatefulWidget {
  final String titulo;
  EditarUsuario({Key key, this.titulo}) : super(key: key);

  @override
  _EditarUsuarioState createState() => new _EditarUsuarioState();
}

/// Final de la clase stateful
///----------------------------------------------------------------------------

///----------------------------------------------------------------------------
/// inicio de la clase stateless
/// Ventana Stateles de Editar de usuario.
///
///
/// Autor: Joseph Rementería (b55824)
class _EditarUsuarioState extends State<EditarUsuario> {
  ///--------------------------------------------------------------------------
  /// Sección de constantes.
  /// TODO: remember to edit this when the backed is tunned.
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

  ///--------------------------------------------------------------------------
  /// Varibles a usar.
  RestService _restService = new RestService();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ///--------------------------------------------------------------------------
  /// Variables "repositorio"
  String _nombre = "";
  String _apellidos = "";
  String _telefono = "";
  String _correo = "";

  ///--------------------------------------------------------------------------
  /// Métodos
  @override

  /// Override of the method initState to get the values of the json
  ///
  /// Autor: Joseph Rementería (b55824).
  void initState() {
    super.initState();

    ///------------------------------------------------------------------------
    /// Ejemplo del JSON leído.
    ///static String json =
    ///"{
    ///\"correo\":\"joe@example.com\",
    ///\"nombre\":\"joe\",
    ///\"apellidos\":\"rementería\",
    ///\"telefono\":\"12345678\"
    ///}";
    ///------------------------------------------------------------------------
    /// Obteniendo el nombre del json.
    TokenService.getNombre().then((respuesta) {
      setState(() {
        this._nombre = respuesta;
      });
    });

    ///------------------------------------------------------------------------
    /// Obteniendo los apellidos del json.
    TokenService.getApellidos().then((respuesta) {
      setState(() {
        this._apellidos = respuesta;
      });
    });

    ///------------------------------------------------------------------------
    /// Obteniendo el teléfono del json.
    TokenService.getTelefono().then((respuesta) {
      setState(() {
        this._telefono = respuesta;
      });
    });

    ///------------------------------------------------------------------------
    /// Obteniendo el correo del json.
    TokenService.getSub().then((respuesta) {
      setState(() {
        this._correo = respuesta;
      });
    });

    ///------------------------------------------------------------------------
  }

  /// Definición de ventana Editar Usuario
  ///
  /// Autor Joseph Rementería (b55824)
  @override
  Widget build(BuildContext context) {
    ///------------------------------------------------------------------------
    return new Scaffold(
      ///----------------------------------------------------------------------
      /// Barra superior en la pantalla de editar usuario
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          this._nombre + " " + this._apellidos,
          style: TextStyle(color: Paleta.Blanco)
          ),
        backgroundColor: Paleta.Gris,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Paleta.Blanco,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      ///----------------------------------------------------------------------
      resizeToAvoidBottomPadding: true,
      ///----------------------------------------------------------------------
      /// El cuerpo "scrolleable" de la pantalla
      body: ListView(
        ///--------------------------------------------------------------------
        /// Lista de hijos del elemento cuerpo "scrolleable"
        children: <Widget>[
          ///----------------------------------------------------------------
          /// Primer elemento en el cuerpo "scrolleable"
          /// Sección que muestra la foto y el botón plano que la edita.
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///------------------------------------------------------------
              /// TODO: por ahora un ícono, cambiar a foto.
              IconButton(
                icon: Icon(Icons.account_circle),
                color: Paleta.Gris,
                iconSize: 100,
                onPressed: null,
              ),

              ///------------------------------------------------------------
              /// TODO: hacer que el botón haga lo que tiene que hacer
              BotonPlano(
                "Cambiar foto",
                Paleta.Gris,
                TamanoLetra.H3,
                onPressed: () {
                  print("TODO: obtener la imagen del servidor.");
                },
              ),
            ],
          ),

          ///----------------------------------------------------------------
          Form(
              key: this._formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ///----------------------------------------------------------
                  /// Sección que inicializa la entrada de texto
                  /// para el nombre del usuario.
                EntradaTextoEtiqueta(
                  this._nombre,
                  "Nombre",
                  false,
                  TamanoLetra.H2,
                  FontWeight.normal,
                  validator: (value) {
                    if(value == ""){
                      value = this._nombre;
                    }
                    String error = ValidadorLexico.validarNombre(value);
                    return error;
                  }
                ),

                  ///----------------------------------------------------------
                  /// Sección que inicializa la entrada de texto
                  /// para los apellidos del usuario.
                  EntradaTextoEtiqueta(
                      this._apellidos,
                      "Apellido",
                      false,
                      TamanoLetra.H2,
                      FontWeight.normal,
                      validator: (value) {
                        if(value == ""){
                          value = this._apellidos;
                        }
                        String error = ValidadorLexico.validarNombre(value);
                        return error;
                      }
                  ),
                  ///----------------------------------------------------------
                  /// Sección que inicializa la entrada de texto
                  /// para el teléfono del usuario.
                  EntradaTextoEtiqueta(
                    this._telefono,
                    "Teléfono",
                    false,
                    TamanoLetra.H2,
                    FontWeight.normal,
                    validator: (value) {
                      if (value == ""){
                      value = this._telefono;
                      }
                      String error = ValidadorLexico.validarNombre(value);
                      return error;
                     }
                  ),

                  ///----------------------------------------------------------
                  /// Sección que inicializa la entrada de texto
                  /// para el correo del usuario.
                  EntradaTextoEtiqueta(
                    this._correo,
                    "Correo",
                    false,
                    TamanoLetra.H2,
                    FontWeight.normal,
                    validator: (value) {
                      if (value == ""){
                        value = this._correo;
                      }
                      String error = ValidadorLexico.validarNombre(value);
                      return error;
                    }
                  ),
                  ///----------------------------------------------------------
                  /// Sección que inicializa el botón para enviar los datos al
                  /// servidor para editar la tupla en la base de datos.
                  Container(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                    child: Boton(
                      "Confirmar",
                      Paleta.Naranja,
                      Paleta.Blanco,
                      onPressed: () {
                        enviarCambios();
                      },
                    ),
                  ),

                  ///----------------------------------------------------------
                  /// Sección que inicializa el botón para eliminar la tupla.
                  /// Autor: Kevin Jiménez
                  Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: BotonEliminarCuenta(onPressed: _borrarUsuario),
                  ),

                  ///----------------------------------------------------------
                ],
              )),

          ///----------------------------------------------------------------
        ],
      ),

      /// Final de la lista de "scrolleables"
      ///----------------------------------------------------------------------
    );

    /// Final del return
    ///------------------------------------------------------------------------
  }

  /// This is the method that submit every changes in both the storage
  /// and the server
  ///
  /// Author: Joseph Rementería (b55284).
  void enviarCambios() async {
    try {
      ///----------------------------------------------------------------------
      /// Se envian al servicio para ser procesados en el server.
      String respuesta = await this._restService.editarPerfil(
          this._correo, this._nombre, this._apellidos, this._telefono);

      ///----------------------------------------------------------------------
      /// Se muestran las alertas correspondientes.
      if (respuesta == "error") {
        ///--------------------------------------------------------------------
        DialogoAlerta.mostrarAlerta(context, ERROR, ERRORAUTH, OK);
      } else if (respuesta == "noauth") {
        ///--------------------------------------------------------------------
        DialogoAlerta.mostrarAlerta(context, DATOSINCORRECTOS, BADLOGIN, OK);
      } else {
        ///--------------------------------------------------------------------
        TokenService.editarJson(
            this._nombre, this._apellidos, this._telefono, this._correo);
        Navigator.of(context).pushReplacementNamed('/home');
      }

      ///----------------------------------------------------------------------
    } catch (e) {
      ///----------------------------------------------------------------------
      DialogoAlerta.mostrarAlerta(context, ERRORDECONECCION, ERRORCONN, OK);

      ///----------------------------------------------------------------------
    }
  }

  /// Envia un request al backend para borrar al usuario.
  ///
  /// Despues de enviar el request, desloguea al usuario y lo envia a
  /// la pagina de Login.
  ///
  /// Autor: Kevin Jimenez
  void _borrarUsuario() {
    try {
      _restService.borrarUsuario(this._correo);
      TokenService.borrarToken();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: routes['/login']),
          ModalRoute.withName('/'));
    } catch (e) {
      DialogoAlerta.mostrarAlerta(context, "Error de conexión",  "Hubo un error tratando de realizar la conexión.\n" +
          "Por favor, verifique su conexión a internet e inténtelo de nuevo.", 'OK');
    }
  }
}

/// Final de la clase stateless
///----------------------------------------------------------------------------
