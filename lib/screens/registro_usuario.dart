import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/widgets/flecha_atras.dart';
import 'package:CoopeticoTaxiApp/widgets/agregar_foto.dart';
import 'package:CoopeticoTaxiApp/widgets/formulario_registro.dart';

/// Autor: Valeria Zamora
///
/// Formulario para agregar un usuario a la base de datos.
class RegistroUsuario extends StatefulWidget {
  final String titulo;
  RegistroUsuario({Key key, this.titulo}) : super(key: key);

  @override
  _RegistroUsuarioState createState() => new _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: FlechaAtras(Paleta.Blanco),
            title: Text('Registrarse', style: TextStyle(color: Paleta.Blanco)),
            centerTitle: true,
            backgroundColor: Paleta.Gris,
            iconTheme: IconThemeData(color: Paleta.Blanco)
        ),
        body: ListView(   //Para que sea scrolleable
          children: <Widget>[
            // AgregarFoto(Paleta.Gris, onPressed: null), // funcionalidad pendiente
            Center(
              child: FormularioRegistro(),
            )
          ],
        )
    );
  }
}