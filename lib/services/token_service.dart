import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Clase encargada de guardar en el almacenamiento del dispositivo
/// el token de login para que el usuario no tenga que autenticarse
/// cada vez que abre la aplicación.
class TokenService{

  /// Se ejecuta cuando un usuario hace un log in exitoso.
  /// Requiere que [respuesta] sea un string JSON con formato válido.
  /// Requiere que todos los permisos en el JSON sean Strings.
  static void guardarTokenLogin(String respuesta) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map respuestaJSON = jsonDecode(respuesta);

    String sub = respuestaJSON["sub"];
    List<String> permisos = new List<String>.from(respuestaJSON["permisos"]);
    String rol = respuestaJSON["rol"];
    int iat = respuestaJSON["iat"];
    int exp = respuestaJSON["exp"];

    await preferences.setString('sub', sub);
    await preferences.setStringList('permisos', permisos);
    await preferences.setString('rol', rol);
    await preferences.setInt('iat', iat);
    await preferences.setInt('exp', exp);
  }

  /// Método borra el token del dispositivo.
  /// Se debe ejecutar al hacer logout de la aplicación.
  static void borrarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('sub');
    await preferences.remove('permisos');
    await preferences.remove('rol');
    await preferences.remove('iat');
    await preferences.remove('exp');
  }

  /// Método devuelve true si existe un token en el dispositivo con una fecha
  /// de expiración que aún no ha ocurrido.
  static Future<bool> existeTokenValido() async{
    bool existeTokenValido = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String sub = preferences.getString("sub");
    int exp = preferences.getInt("exp");
    exp = exp * 1000;

    if(sub != null && DateTime.fromMillisecondsSinceEpoch(exp).isAfter(DateTime.now())){ //Si existe un token y no ha expirado.
      existeTokenValido = true;
    }

    return existeTokenValido;
  }

  static Future<String> getSub() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("sub");
  }

  static Future<List<String>> getPermisos() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("permisos");

  }

  static Future<String> getRol() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("rol");

  }

  static Future<int> getIat() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("iat");

  }

  static Future<int> getExp() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("exp");

  }
}
