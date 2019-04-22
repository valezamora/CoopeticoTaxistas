import 'package:flutter/material.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Autor: Valeria Zamora
///
/// Clase que muestra la foto del usuario
/// NOTA: temporalmente muestra un icono solamente
class FotoUsuario extends StatelessWidget {
  final String url;

  FotoUsuario(this.url);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
      child: IconButton(
        icon: Icon(Icons.account_circle),
        color: Paleta.Gris,
        iconSize: 100,
        onPressed: null,
      ),
    );
  }
}