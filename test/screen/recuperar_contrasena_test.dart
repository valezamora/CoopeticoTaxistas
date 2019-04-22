import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/screens/home.dart';

import 'package:CoopeticoTaxiApp/screens/recuperar_contrasena.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';



/// Pruebas para la pantalla de recuperacion de contrasena.
/// 
/// Autor: Kevin Jiménez.
void main() {
  /// Prueba que haya una entradas de texto, y un boton.
  testWidgets('Estructura pantalla correcta',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecuperarContrasena()));

    final buscadorEntradaTexto = find.byType(EntradaTexto);
    final buscadorBoton = find.byType(Boton);

    expect(buscadorEntradaTexto, findsOneWidget);
    expect(buscadorBoton, findsOneWidget);
  });

  /// Prueba que si hay una entrada de texto vacía, no redirige.
  testWidgets('Campo vacío no redirige', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecuperarContrasena()));

    final buscadorBoton = find.byType(RaisedButton);
    await tester.tap(buscadorBoton); //Presiono el botón con campo vacío.

    await tester.pumpAndSettle();

    final buscadorErrorEntrada = find.text('Por favor ingrese su correo.');
    final buscadorAlertaDialogo = find.byType(AlertDialog);

    expect(buscadorErrorEntrada, findsOneWidget);
    expect(buscadorAlertaDialogo, findsNothing);
   
  });

  /// Prueba que si la entrada de texto tiene texto,
  /// pero tiene formato inválido, no redirige.
  testWidgets('Campo con formato inválido no redirige',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecuperarContrasena()));

    final buscadorEntradaTexto = find.byType(TextFormField);
    final buscadorBoton = find.byType(RaisedButton);

    await tester.enterText(buscadorEntradaTexto, 'correoinvalido.com');

    await tester.tap(buscadorBoton); //Presiono el botón con un campo inválido
    await tester.pumpAndSettle();

    final buscadorErrorEntrada = find.text('Correo inválido.');
    final buscadorHome = find.byType(Home);

    expect(buscadorErrorEntrada, findsOneWidget);
    expect(buscadorHome, findsNothing);
  });

  /// Prueba que si la entradas de texto tiene texto,
  /// y si es válida, se redirige a otra pantalla.
  testWidgets('Campos válidos redirigen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecuperarContrasena()));

    final buscadorEntradaTexto = find.byType(TextFormField);
    final buscadorBoton = find.byType(RaisedButton);

    await tester.enterText(
        buscadorEntradaTexto, 'correo@noestaenelbackend.com');

    await tester.tap(buscadorBoton); //Presiono el botón con un campo inválido
    await tester.pumpAndSettle();

    //Solo busca AlertaDialogo porque se ingresa un correo válido 
    final buscadorAlertaDialogo = find.byType(AlertDialog);

    expect(buscadorAlertaDialogo, findsWidgets);
  });
}
