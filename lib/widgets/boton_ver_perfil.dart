import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Clase que muestra el icono y nombre del usuario y permite acceder al perfil.
///
/// Autor: Valeria Zamora
class BotonPerfilUsuario extends StatelessWidget {
  final String nombre;

  BotonPerfilUsuario(this.nombre);



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Paleta.Gris,
            iconSize: 50,
            onPressed: () {
              // navigate al perfil del usuario
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          Text(
            this.nombre,
            style: TextStyle(color: Paleta.Gris),
          )
        ],
      ),

    );
  }
}