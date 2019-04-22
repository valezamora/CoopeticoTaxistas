import 'package:CoopeticoTaxiApp/widgets/flecha_atras.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/services/rest_service.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/validador_lexico.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_alerta.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';


/// Autor: Kevin Jiménez.
/// Ventana para recuperar contraseña.
class RecuperarContrasena extends StatefulWidget {
  @override
  RecuperarContrasenaState createState() {
    return RecuperarContrasenaState();
  }
}


/// Autor: Kevin Jiménez.
/// Estado  ventana [RecuperarContrasena].
class RecuperarContrasenaState extends State<RecuperarContrasena> {
  String _correo;
  RestService _restService = new RestService();
  final formKey = GlobalKey<FormState>();

  /// Contruye el widget
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          leading: FlechaAtras(Paleta.Blanco),
          title: Text('Recuperar contraseña',
              style: TextStyle(color: Paleta.Blanco)),
          centerTitle: true,
          backgroundColor: Paleta.Gris,
          iconTheme: IconThemeData(color: Paleta.Blanco)),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EntradaTexto("Correo", "Correo", false, validator: (value) {
                      String error = ValidadorLexico.validarCorreo(value);
                      if (error == null) {
                        this._correo = value;
                      }
                      return error;
                    }),
                    Container(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                      child: Boton(
                          "Recuperar contraseña", Paleta.Naranja, Paleta.Blanco,
                          onPressed: () {
                        if (formKey.currentState.validate()) {
                          enviarCorreo();
                        }
                      }),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Envia la dirrecin de correo al backened.
  ///
  /// Envia la dirrecin de correo al backened y muestra una ventana informativa al usuario.
  void enviarCorreo() async {
    await _restService.obtenerTokenRecuperacionContrasena(_correo);
    DialogoAlerta.mostrarAlertaConAccion(
        context,
        'Correcto',
        'Se le enviara un mensaje al correo ingresado con instrucciones para recuperar su contraseña.',
        'Ok', 
        onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
  }
}
