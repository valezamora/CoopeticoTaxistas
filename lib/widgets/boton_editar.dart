import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Autor: Valeria Zamora
/// 
/// Boton para editar el perfil del usuario
class BotonEditar extends StatelessWidget {
  BotonEditar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 60,
      child: IconButton(
        icon: Icon(Icons.edit),
        color: Paleta.Gris,
        iconSize: 25,
        alignment: Alignment.centerRight,
        onPressed: () {
          Navigator.pushNamed(context, '/editar');
        },
      ),
    );
  }
}