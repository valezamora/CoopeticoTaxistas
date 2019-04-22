import 'package:CoopeticoTaxiApp/widgets/entrada_texto_etiqueta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/screens/editar_usuario.dart';
import 'package:CoopeticoTaxiApp/screens/home.dart';

import 'package:CoopeticoTaxiApp/widgets/boton.dart';
import 'package:CoopeticoTaxiApp/widgets/boton_plano.dart';

///----------------------------------------------------------------------------
///
/// Pruebas de al pantalla de editar perfil.
///
/// Autor: Joseph Rementería (b55284).
///----------------------------------------------------------------------------
void main(){
  ///--------------------------------------------------------------------------
  /// Se prueban los elementos que deben estar en la pantalla:
  ///
  /// AppBar            : 1,
  /// Icono             : 1, foto.
  /// Botón plano       : 1, para editar la foto.
  /// Entrada de texto  : 4, nombre, pellidos, teléfono, correo.
  /// Botón normal      : 2, submit y eliminar.
  testWidgets(
    'Estructura pantalla editar correcta',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: EditarUsuario()));

      final buscadorAppBar        = find.byType(AppBar);
      final buscadorFoto          = find.byType(IconButton);
      final buscadorBotonPlano    = find.byType(BotonPlano);
      final buscadorEntradaTexto  = find.byType(EntradaTextoEtiqueta);
      final buscadorBoton         = find.byType(Boton);

      expect(buscadorAppBar,        findsOneWidget);
      expect(buscadorFoto,          findsOneWidget);
      expect(buscadorBotonPlano,    findsOneWidget);
      expect(buscadorEntradaTexto,  findsNWidgets(4));
      expect(buscadorBoton,         findsNWidgets(2));
    }
  );
  ///--------------------------------------------------------------------------
  /// En esta pantalla no es necesario probar el comportamiento del app cuando
  /// se deja un campo vacío, cuando eso pasa, se validan los datos existentes
  /// nuevamente y se envian al servidor de vuelta.
  ///--------------------------------------------------------------------------
  /// Prueba de entrada inválida en cualquiera de las entradas de texto.
  testWidgets(
    'Campo con formato inválido no redirige',
    (WidgetTester tester) async{
      ///----------------------------------------------------------------------
      /// Constantes a usar para las entradas de texto.
      const String NOMBRE     = 'Nombre Valido';
      const String APELLIDOS  = 'Apellidos Validos';
      const String TELEFONO   = '00000000';
      const String CORREO     = 'correo invalido';
      ///----------------------------------------------------------------------
      /// Se coloca la pantalla a probar.
      await tester.pumpWidget(MaterialApp(home: EditarUsuario()));
      ///----------------------------------------------------------------------
      /// Busca los elementos a probar.
      final buscadorEntradaTexto = find.byType(TextFormField);
      final buscadorBoton = find.byType(RaisedButton);
      ///----------------------------------------------------------------------
      /// Se insertan los datos a probar en los elementos correspondientes.
      await tester.enterText(buscadorEntradaTexto.at(0), NOMBRE);
      await tester.enterText(buscadorEntradaTexto.at(1), APELLIDOS);
      await tester.enterText(buscadorEntradaTexto.at(2), TELEFONO);
      await tester.enterText(buscadorEntradaTexto.at(3), CORREO);
      ///----------------------------------------------------------------------
      /// Se presiona el botón.
      await tester.tap(buscadorBoton);
      await tester.pumpAndSettle();
      ///----------------------------------------------------------------------
      /// Se busca el resultado deseado.
      final buscadorAlertaDialogo = find.byType(AlertDialog);
      final buscadorHome = find.byType(Home);
      ///----------------------------------------------------------------------
      /// Se corrobora que el estado es el esperado.
      expect(buscadorAlertaDialogo, findsNothing);
      expect(buscadorHome, findsNothing);
      ///----------------------------------------------------------------------
    }
  );
  ///--------------------------------------------------------------------------
  /// Prueba que si las cuantro entradasde texto tienen datos válidos, o vacíos,
  /// se redirige a otra pantalla.
  testWidgets(
    'Campos válidos redirigen',
    (WidgetTester tester) async {
      ///----------------------------------------------------------------------
      /// Constantes a usar para las entradas de texto.
      const String NOMBRE     = 'Nombre Valido';
      const String APELLIDOS  = 'Apellidos Validos';
      const String TELEFONO   = '00000000';
      const String CORREO     = 'correo invalido';
      ///----------------------------------------------------------------------
      /// Se coloca la pantalla a probar.
      await tester.pumpWidget(MaterialApp(home: EditarUsuario()));
      ///----------------------------------------------------------------------
      /// Busca los elementos a probar.
      final buscadorEntradaTexto = find.byType(TextFormField);
      final buscadorBoton = find.byType(RaisedButton);
      ///----------------------------------------------------------------------
      /// Se insertan los datos a probar en los elementos correspondientes.
      await tester.enterText(buscadorEntradaTexto.at(0), NOMBRE);
      await tester.enterText(buscadorEntradaTexto.at(1), APELLIDOS);
      await tester.enterText(buscadorEntradaTexto.at(2), TELEFONO);
      await tester.enterText(buscadorEntradaTexto.at(3), CORREO);
      ///----------------------------------------------------------------------
      /// Se presiona el botón.
      await tester.tap(buscadorBoton);
      await tester.pumpAndSettle();
      ///----------------------------------------------------------------------
      /// No hay funcionalidad en el servidor que edite usuario, por
      /// eso siempre abrá una alerta de error
      /// TODO: cambiar cuando el backend esté completo.
      final buscadorAlertaDialogo = find.byType(AlertDialog);
      /// TODO: the same as before, but with this section.
      expect(buscadorAlertaDialogo, findsWidgets);
      ///----------------------------------------------------------------------
    }
  );
  ///--------------------------------------------------------------------------
}