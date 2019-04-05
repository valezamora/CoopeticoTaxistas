import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets_lib.dart';
import '../util/util_lib.dart';

class LoginTaxista extends StatefulWidget {
  final String titulo;
  LoginTaxista({Key key, this.titulo}) : super(key: key);

  @override
  _LoginTaxistaState createState() => new _LoginTaxistaState();
}

class _LoginTaxistaState extends State<LoginTaxista> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LogoCoopetico(),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Etiqueta('Taxistas', TamanoLetra.H1, FontWeight.bold),
            ),
            /*Form(
              key: _formKey,
              autovalidate: true,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[*/
            EntradaTexto("Correo"),
            EntradaTexto("Contraseña"),
            Container(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Boton(
                  "Iniciar sesión",
                  Paleta.Naranja,
                  onPressed: () {
                    print("TO DO");
                  }),
            ),
            /*],
              )
            ),*/
            BotonPlano(
              "Recuperar contraseña",
              Paleta.Azul,
              TamanoLetra.H3,
              onPressed: (){
                print("TO DO");
              },
            )
          ],
        ),
      ),
    );
  }
}