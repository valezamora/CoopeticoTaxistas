import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:CoopeticoTaxiApp/widgets/logo_coopetico.dart';

/// Autor: Marco Venegas.
/// Pruebas para el widget del logo de Coopetico.
void main() {
  /// Prueba que el logo sea una imagen
  testWidgets('Logo es imagen', (WidgetTester tester) async {
    await tester.pumpWidget(LogoCoopetico());

    final buscadorImagen = find.byType(Image);

    expect(buscadorImagen, findsOneWidget);
  });
}
