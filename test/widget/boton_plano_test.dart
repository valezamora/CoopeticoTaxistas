import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';

/// Autor: Marco Venegas.
/// Pruebas para un boton plano.
void main() {
  /// Prueba que un widget de boton plano tenga texto.
  testWidgets('Boton plano tiene texto', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BotonPlano("Test", Paleta.Verde, TamanoLetra.H3)));

    final buscadorTexto = find.text("Test");

    expect(buscadorTexto, findsOneWidget);
  });

  /// Prueba que un widget de boton plano sea un FlatButton
  testWidgets('Boton plano es FlatButton', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: BotonPlano("Test", Paleta.Verde, TamanoLetra.H3)));

    final buscadorFlatButton = find.byType(FlatButton);

    expect(buscadorFlatButton, findsOneWidget);
  });
}
