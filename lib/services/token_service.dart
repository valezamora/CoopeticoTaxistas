import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/**
 * Clase encargada de guardar en el almacenamiento del dispositivo
 * el token de login para que no tenga que autenticarse cada vez que abre la aplicación.
 */

class TokenService{

  /**
   * Se ejecuta cuando un usuario hace un log in exitoso.
   * REQ: Recibir un string JSON con formato válido.
   * REQ: Todos los permisos deben ser Strings.
   */
  void guardarTokenLogin(String respuesta) async {
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

  /**
   * Se debe ejecutar al hacer logout de la aplicación.
   */
  void borrarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('sub');
    await preferences.remove('permisos');
    await preferences.remove('rol');
    await preferences.remove('iat');
    await preferences.remove('exp');
  }

  Future<String> getSub() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString("sub");
  }

  Future<List<String>> getPermisos() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getStringList("permisos");

  }

  Future<String> getRol() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString("rol");

  }

  Future<int> getIat() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt("iat");

  }

  Future<int> getExp() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt("exp");

  }

}
