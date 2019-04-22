
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/widgets/boton_eliminar_cuenta.dart';


void main() {
  /// Prueba que haya un boton de eliminar cuenta.
  testWidgets('Existencia del botón', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BotonEliminarCuenta(onPressed: (){},)));

    final buscadorBoton = find.text('Eliminar Cuenta');

    expect(buscadorBoton, findsOneWidget);
  });

  /// Prueba que si se orrime el boton se muestre un dialogo de confirmación.
  testWidgets('Se muestra dialogo de confirmación',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:  BotonEliminarCuenta(onPressed: (){},)));

    final buscadorBoton = find.byType(RaisedButton);

    await tester.tap(buscadorBoton); 

    await tester.pumpAndSettle();


    final buscadorConfirmacionDialogo = find.byType(AlertDialog);

    expect(buscadorConfirmacionDialogo, findsOneWidget);
  }); 
}
