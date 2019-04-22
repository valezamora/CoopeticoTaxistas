import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/widgets/texto_perfil.dart';

/// Clase que muestra los datos personales del usuario.
///
/// Autor: Valeria Zamora
class InfoUsuario extends StatelessWidget {
  final String nombre;
  final String correo;
  final String telefono;
  InfoUsuario(this.correo, this.nombre, this.telefono);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        TextoPerfil("Nombre", nombre),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        TextoPerfil("Teléfono", telefono),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
        TextoPerfil("Correo", correo),
        Divider(
          color: Paleta.Gris,
          height: 40,
        ),
      ],
    );
  }
}