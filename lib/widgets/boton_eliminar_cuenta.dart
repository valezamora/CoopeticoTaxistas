import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/dialogo_confirmacion.dart';

class BotonEliminarCuenta extends StatelessWidget {
  final onPressed;
  BotonEliminarCuenta({@required this.onPressed});

  Widget build(BuildContext context) {
    return Boton(
      "Eliminar Cuenta",
      Paleta.Rojo,
      Paleta.Blanco,
      onPressed: () {
        DialogoConfirmacion.mostrarAlerta(
          context,
          'Borrar cuenta',
          '¿Esta seguro que desea continuar?',
          onPressed: onPressed,
          textoBoton: 'Borrar cuenta',
        );
      },
    );
  }

  
}
