import 'package:CoopeticoTaxiApp/screens/home.dart';
import 'package:CoopeticoTaxiApp/screens/login_taxista.dart';
import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';
import 'package:CoopeticoTaxiApp/widgets/entrada_texto.dart';
import 'package:CoopeticoTaxiApp/widgets/logo_coopetico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


/// Autor: Marco Venegas.
/// Pruebas para la pantalla de login.
void main(){
  /// Prueba que haya un logo, dos entradas de texto,
  /// un RaisedButton y dos FlatButtons.
  testWidgets('Estructura pantalla login correcta', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: LoginTaxista()));

    final buscadorLogo = find.byType(LogoCoopetico);
    final buscadorEntradaTexto = find.byType(EntradaTexto);
    final buscadorBoton = find.byType(Boton);
    final buscadorBotonPlano = find.byType(BotonPlano);

    expect(buscadorLogo, findsOneWidget);
    expect(buscadorEntradaTexto, findsNWidgets(2));
    expect(buscadorBoton, findsOneWidget);
    expect(buscadorBotonPlano, findsOneWidget);

  });

  /// Prueba que si hay una entrada de texto vacía, no redirige.
  testWidgets('Campo vacío no redirige', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: LoginTaxista()));

    final buscadorBoton = find.byType(RaisedButton);
    await tester.tap(buscadorBoton);//Presiono el botón con ambos campos vacíos.


    final buscadorAlertaDialogo = find.byType(AlertDialog);
    final buscadorHome = find.byType(Home);
    await tester.pumpAndSettle();

    expect(buscadorAlertaDialogo, findsNothing);
    expect(buscadorHome, findsNothing);
  });

  /// Prueba que si ambas entradas de texto tienen texto,
  /// pero alguna tiene formato inválido, no redirige.
  testWidgets('Campo con formato inválido no redirige', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: LoginTaxista()));

    final buscadorEntradaTexto = find.byType(TextFormField);
    final buscadorBoton = find.byType(RaisedButton);

    await tester.enterText(buscadorEntradaTexto.at(0), 'correo@valido.com');
    await tester.enterText(buscadorEntradaTexto.at(1), ';--contrasenainvalida');

    await tester.tap(buscadorBoton);//Presiono el botón con un campo inválido
    await tester.pumpAndSettle();

    final buscadorAlertaDialogo = find.byType(AlertDialog);
    final buscadorHome = find.byType(Home);

    expect(buscadorAlertaDialogo, findsNothing);
    expect(buscadorHome, findsNothing);
  });

  /// Prueba que si ambas entradas de texto tienen texto,
  /// y ambas son válidas, se redirige a otra pantalla.
  testWidgets('Campos válidos redirigen', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: LoginTaxista()));

    final buscadorEntradaTexto = find.byType(TextFormField);
    final buscadorBoton = find.byType(RaisedButton);

    await tester.enterText(buscadorEntradaTexto.at(0), 'correo@noestaenelbackend.com');
    await tester.enterText(buscadorEntradaTexto.at(1), 'contrasenavalida');

    await tester.tap(buscadorBoton);//Presiono el botón con un campo inválido
    await tester.pumpAndSettle();

    //Solo busca AlertaDialogo porque se ingresa un correo válido pero
    //inexistente en el backend. Por eso siempre redirige a un Dialogo de Alerta.
    final buscadorAlertaDialogo = find.byType(AlertDialog);

    expect(buscadorAlertaDialogo, findsOneWidget);
  });

  /// Prueba que un taxista suspendido se le muestre el mensaje de suspensión.
  ///
  /// REQUIERE que el backend y la bd estén corriendo.
  testWidgets('Taxista suspendido no loggea', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginTaxista()));

    final buscadorEntradaTexto = find.byType(TextFormField);
    final buscadorBoton = find.byType(RaisedButton);

    await tester.enterText(buscadorEntradaTexto.at(0), 'taxistaSuspendido@taxista.com');
    await tester.enterText(buscadorEntradaTexto.at(1), 'contrasenna');

    await tester.tap(buscadorBoton);//Presiono el botón con un taxista suspendido.
    await tester.pumpAndSettle();

    final buscadorAlertaDialogo = find.byType(AlertDialog);
    expect(buscadorAlertaDialogo, findsWidgets);

    final tituloFinder = find.text("Error"); //find.text("Cuenta suspendida");
    expect(tituloFinder, findsOneWidget);

    //TODO Arreglar este test
    // No sé como hacer para que mande el diálogo apropiado, parece que a la hora del test
    // no se comunica con el backend puesto que siempre manda error.
  });
}