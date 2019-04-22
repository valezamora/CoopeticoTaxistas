/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CoopeticoTaxiApp/screens/recuperar_contrasena.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';

void main() {
  testWidgets(
    'Se ingresa un correo con formato valido',
    (WidgetTester tester) async {
      await tester.pumpWidget(RecuperarContrasena());

      await tester.enterText(
          find.byType(TextFormField), 'coopeticotaxi@gmail.com');

      await tester.pump();

      await tester.tap(find.byType(RaisedButton));

      await tester.pump();

      expect(find.text('Correcto'), findsOneWidget);
    },
  );
}
*/
