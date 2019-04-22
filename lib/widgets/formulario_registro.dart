import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';

/// Autor: Valeria Zamora
/// Clase que contiene el formulario para registrar un usuario nuevo en la base de datos.
class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({Key key}) : super(key: key);

  @override
  _FormularioRegistroState createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RestService _restService = new RestService();

  // Variables donde se almacenan los datos que se envía al backend
  String _correo = "";
  String _nombre = "";
  String _apellidos = "";
  String _telefono = "";
  String _contrasena = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EntradaTexto(
            "Correo *",
            "Correo *",
            false,
            validator: (value) {
              String error = ValidadorLexico.validarCorreo(value);
              if(error == null){
                this._correo = value;
              }
              return error;
          }, ),
          EntradaTexto(
            "Nombre *",
            "Nombre *",
            false,
            validator: (value) {
              String error = ValidadorLexico.validarNombre(value);
              if(error == null){
                this._nombre = value;
              }
              return error;
            },
          ),
          EntradaTexto(
            "Apellidos *",
            "Apellidos *",
            false,
            validator: (value) {
              String error = ValidadorLexico.validarApellido(value);
              if(error == null){
                this._apellidos = value;
              }
              return error;
              },
          ),
          EntradaTexto(
            "Teléfono *",
            "Teléfono *",
            false,
            validator: (value) {
              String error = ValidadorLexico.validarTelefono(value);
              if(error == null){
                this._telefono = value;
              }
              return error;
              },
          ),
          EntradaTexto(
            "Contraseña *",
            "Contraseña *",
            true,
            validator: (value) {
              String error = ValidadorLexico.validarContrasena(value);
              if(error == null){
                this._contrasena = value;
              }
              return error;
            },
          ),
          EntradaTexto(
            "Confirmar contraseña *",
            "Confirmar contraseña *",
            true,
            validator: (value) {
              String error = ValidadorLexico.validarContrasenaValidada(value, _contrasena);
              return error;
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text('* Campos requeridos.', style: TextStyle(color: Paleta.Gris)),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
            child:
            Boton("Registrarse", Paleta.Naranja, Paleta.Blanco,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    agregarUsuario();
                  }
                }),
          ),
        ],
      ),
    );
  }


  /// Envía la información del usuario al backend mediante un HTTP POST.
  /// Recibe 200 si se agrega el usuario correctamente.
  /// Recibe 400 si el correo ya se encuentra en la base de datos.
  ///
  void agregarUsuario() async {
      int respuesta = await _restService.signup(_correo, _nombre, _apellidos, _telefono,_contrasena);
      print(respuesta);
      if (respuesta == 200) {
        Navigator.of(context).pushReplacementNamed('/login'); //Redireccionar al home screen.
        DialogoAlerta.mostrarAlerta(context, "EXITO", "Se ha creado el usuario correctamente.", "OK");
      } else {
        if (respuesta == 400) {
          DialogoAlerta.mostrarAlerta(
              context, "ERROR", "El correo ingresado ya existe.", "OK");
        } else {
          DialogoAlerta.mostrarAlerta(
              context, "ERROR", "No se pudo crear el usuario.", "OK");
        }
      }
  }
}
