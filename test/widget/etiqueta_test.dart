import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:CoopeticoTaxiApp/widgets/etiqueta.dart';
import 'package:CoopeticoTaxiApp/util/tamano_letra.dart';

/// Autor: Marco Venegas.
/// Pruebas para las etiquetas de texto.
void main() {
  /// Prueba que un widget de etiqueta, en efecto, tenga texto.
  testWidgets('Etiqueta tiene texto', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Etiqueta("Test", TamanoLetra.H1, FontWeight.normal)));

    final buscadorTexto = find.text("Test");

    expect(buscadorTexto, findsOneWidget);
  });
}
