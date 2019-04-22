import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Autor: Marco Venegas.
/// Clase encargada de guardar en el almacenamiento del dispositivo
/// el token de login para que el usuario no tenga que autenticarse
/// cada vez que abre la aplicación.
class TokenService {

  /// Se ejecuta cuando un usuario hace un log in exitoso.
  /// Requiere que [respuesta] sea un string JSON con formato válido.
  /// Requiere que todos los permisos en el JSON sean Strings.
  ///
  /// Autor: Marco Venegas
  static void guardarTokenLogin(String respuesta) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map respuestaJSON = jsonDecode(respuesta);

    String sub = respuestaJSON["sub"];
    String nombre = respuestaJSON["nombre"];
    String apellidos = respuestaJSON["apellidos"];
    String telefono = respuestaJSON["telefono"];
    String fotoUrl = respuestaJSON["fotoUrl"];
    List<String> permisos = new List<String>.from(respuestaJSON["permisos"]);
    String rol = respuestaJSON["rol"];
    int iat = respuestaJSON["iat"];
    int exp = respuestaJSON["exp"];

    await preferences.setString('sub', sub);
    await preferences.setString('nombre', nombre);
    await preferences.setString('apellidos', apellidos);
    await preferences.setString('telefono', telefono);
    await preferences.setString('fotoUrl', fotoUrl);
    await preferences.setStringList('permisos', permisos);
    await preferences.setString('rol', rol);
    await preferences.setInt('iat', iat);
    await preferences.setInt('exp', exp);
  }

  /// Método borra el token del dispositivo.
  /// Se debe ejecutar al hacer logout de la aplicación.
  ///
  /// Autor: Marco Venegas
  static void borrarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('sub');
    await preferences.remove('nombre');
    await preferences.remove('apellidos');
    await preferences.remove('telefono');
    await preferences.remove('fotoUrl');
    await preferences.remove('permisos');
    await preferences.remove('rol');
    await preferences.remove('iat');
    await preferences.remove('exp');
  }

  /// Método devuelve true si existe un token en el dispositivo con una fecha
  /// de expiración que aún no ha ocurrido.
  ///
  /// Autor: Marco Venegas
  static Future<bool> existeTokenValido() async {
    bool existeTokenValido = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String sub = preferences.getString("sub");
    String nombre = preferences.getString("nombre");
    String apellidos = preferences.getString("apellidos");
    String telefono = preferences.getString("telefono");
    String fotoUrl = preferences.getString("sub");
    List<String> permisos = preferences.getStringList("permisos");
    String rol = preferences.getString("rol");
    int iat = preferences.getInt("iat");
    int exp = preferences.getInt("exp");


    if (sub != null && nombre != null && apellidos != null && telefono != null &&
        fotoUrl != null && permisos != null && rol != null && iat != null && exp != null &&
        DateTime.fromMillisecondsSinceEpoch((exp * 1000)).isAfter(DateTime.now())) {
      //Si existe un token y no ha expirado.
      existeTokenValido = true;
    }

    return existeTokenValido;
  }

  /// Metodo que guarda los datos del usuario para que puedan ser accedidos
  /// sin hacer un llamado al backend.
  /// Autor: Valeria Zamora
  static void guardarDatosUsuario(String usuario) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map usuarioJSON = jsonDecode(usuario);

    String nombre = usuarioJSON["nombre"];
    String apellidos = usuarioJSON["apellidos"];
    String telefono = usuarioJSON["telefono"];

    await preferences.setString('nombre', nombre);
    await preferences.setString('apellidos', apellidos);
    await preferences.setString('telefono', telefono);
  }

  /// Método que verifica si los datos del usuario ya fueron guardados.
  ///
  /// Autor: Valeria Zamora
  static Future<bool> existenDatosDeUsuario() async{
    bool datos = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String correo = preferences.getString("sub");
    String nombre = preferences.getString("nombre");
    String apellidos = preferences.getString("apellidos");
    String telefono = preferences.getString("telefono");

    if(correo != null && nombre != null && apellidos != null && telefono != null){
      datos = true;
    }

    return datos;
  }

  /// Retorna el correo del usuario.
  /// Autor: Marco Venegas
  static Future<String> getSub() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("sub");
  }

  /// Retorna el nombre del usuario
  /// Autor: Valeria Zamora
  static Future<String> getNombre() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("nombre");
  }

  /// Retorna los apellidos del usuario
  /// Autor: Valeria Zamora
  static Future<String> getApellidos() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("apellidos");
  }

  /// Retorna el telefono del usuario
  /// Autor: Valeria Zamora
  static Future<String> getTelefono() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("telefono");
  }

  /// Retorna el Url de la foto del usuario.
  /// Autor: Marco Venegas
  static Future<String> getFotoUrl() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("fotoUrl");
  }

  /// Retorna los permisos del usuario.
  /// Autor: Marco Venegas
  static Future<List<String>> getPermisos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("permisos");
  }

  /// Retorna el rol del usuario.
  /// Autor: Marco Venegas
  static Future<String> getRol() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("rol");
  }

  /// Retorna el tiempo al que fue generado el token del usuario.
  /// Autor: Marco Venegas
  static Future<int> getIat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("iat");
  }

  /// Retorna el momento del vencimiento del token del usuario.
  /// Autor: Marco Venegas
  static Future<int> getExp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("exp");
  }

  /// Retorna el nombre completo del usuario
  /// Autor: Valeria Zamora
  static Future<String> getnombreCompleto() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("nombre") + " " + preferences.getString("apellidos");
  }

  ///--------------------------------------------------------------------------
  /// Método que guarda los datos editados en el json en disco
  /// Autor: Joseph Rementería (b55824)
  static void editarJson(
    String nombre,
    String apellidos,
    String telefono,
    String correo
  ) async {
    ///------------------------------------------------------------------------
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ///------------------------------------------------------------------------
    await preferences.setString('correo', correo);
    await preferences.setString('nombre', nombre);
    await preferences.setString('apellidos', apellidos);
    await preferences.setString('telefono', telefono);
  }
  ///--------------------------------------------------------------------------
}
