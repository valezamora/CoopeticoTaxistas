import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';

/// Autor: Marco Venegas.
/// Pruebas para las entradas de texto.
void main() {
  /// Prueba que un widget de entrada de texto sea un TextFormField.
  testWidgets('Entrada es TextFormField', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child: Directionality(
                textDirection: TextDirection.ltr,
                child:
                    EntradaTexto("Hint", "Label", false, validator: null)))));

    final buscadorTextFormField = find.byType(TextFormField);

    expect(buscadorTextFormField, findsOneWidget);
  });
}
