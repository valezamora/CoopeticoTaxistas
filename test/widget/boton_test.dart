import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/util/paleta.dart';

/// Autor: Marco Venegas.
/// Pruebas para un boton.
void main() {
  /// Prueba que un widget de boton tenga texto.
  testWidgets('Boton tiene texto', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Boton("Test", Paleta.Verde, Paleta.Negro)));

    final buscadorTexto = find.text("Test");

    expect(buscadorTexto, findsOneWidget);
  });

  /// Prueba que un widget de boton esté dentro de un sized box
  testWidgets('Boton tiene tamaño', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Boton("Test", Paleta.Verde, Paleta.Negro)));

    final buscadorSizedBox = find.byType(SizedBox);

    expect(buscadorSizedBox, findsOneWidget);
  });

  /// Prueba que un widget de boton sea un RaisedButton
  testWidgets('Boton es Raised Button', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Boton("Test", Paleta.Verde, Paleta.Negro)));

    final buscadorRaisedButton = find.byType(RaisedButton);

    expect(buscadorRaisedButton, findsOneWidget);
  });
}
