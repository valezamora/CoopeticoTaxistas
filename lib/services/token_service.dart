import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Autor: Marco Venegas.
/// Clase encargada de guardar en el almacenamiento del dispositivo
/// el token de login para que el taxista no tenga que autenticarse
/// cada vez que abre la aplicación.
class TokenService {

  /// Se ejecuta cuando un taxista hace un log in exitoso.
  /// Requiere que [respuesta] sea un string JSON con formato válido.
  /// Requiere que todos los permisos en el JSON sean Strings.
  ///
  /// Autor: Marco Venegas
  static Future<String> guardarTokenLogin(String respuesta) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map respuestaJSON = jsonDecode(respuesta);

    String rolT = respuestaJSON['rol'];

    if(rolT != 'Taxista'){ //Si algun otro rol intenta ingresar en la aplicación de taxistas retorna false.
      return 'AppEquivocada';
    }

    bool estadoT = respuestaJSON['estado'];

    if(!estadoT){ //Si el taxista se encuentra suspendido
      String justificacionT = respuestaJSON['justificacion'];
      return justificacionT;
    }

    String subT = respuestaJSON['sub'];
    String nombreT = respuestaJSON['nombre'];
    String apellidosT = respuestaJSON['apellidos'];
    String telefonoT = respuestaJSON['telefono'];
    String fotoUrlT = respuestaJSON['fotoUrl'];
    List<String> permisosT = new List<String>.from(respuestaJSON['permisos']);
    int iatT = respuestaJSON['iat'];
    int expT = respuestaJSON['exp'];

    await preferences.setString('subT', subT);
    await preferences.setString('nombreT', nombreT);
    await preferences.setString('apellidosT', apellidosT);
    await preferences.setString('telefonoT', telefonoT);
    await preferences.setString('fotoUrlT', fotoUrlT);
    await preferences.setStringList('permisosT', permisosT);
    await preferences.setString('rolT', rolT);
    await preferences.setInt('iatT', iatT);
    await preferences.setInt('expT', expT);

    return 'OK';
  }

  /// Método borra el token del dispositivo.
  /// Se debe ejecutar al hacer logout de la aplicación.
  ///
  /// Autor: Marco Venegas
  static void borrarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('subT');
    await preferences.remove('nombreT');
    await preferences.remove('apellidosT');
    await preferences.remove('telefonoT');
    await preferences.remove('fotoUrlT');
    await preferences.remove('permisosT');
    await preferences.remove('rolT');
    await preferences.remove('iatT');
    await preferences.remove('expT');
  }

  /// Método devuelve true si existe un token en el dispositivo con una fecha
  /// de expiración que aún no ha ocurrido.
  ///
  /// Autor: Marco Venegas
  static Future<bool> existeTokenValido() async {
    bool existeTokenValido = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String subT = preferences.getString('subT');
    String nombreT = preferences.getString('nombreT');
    String apellidosT = preferences.getString('apellidosT');
    String telefonoT = preferences.getString('telefonoT');
    String fotoUrlT = preferences.getString('subT');
    List<String> permisosT = preferences.getStringList('permisosT');
    String rolT = preferences.getString('rolT');
    int iatT = preferences.getInt('iatT');
    int expT = preferences.getInt('expT');


    if (subT != null && nombreT != null && apellidosT != null && telefonoT != null &&
        fotoUrlT != null && permisosT != null && rolT != null && iatT != null && expT != null &&
        DateTime.fromMillisecondsSinceEpoch((expT * 1000)).isAfter(DateTime.now())) {
      //Si existe un token y no ha expirado.
      existeTokenValido = true;
    }

    return existeTokenValido;
  }

  /// Método que verifica si los datos del taxista ya fueron guardados.
  ///
  /// Autor: Valeria Zamora
  static Future<bool> existenDatosDeUsuario() async{
    bool datos = false;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String correo = preferences.getString('subT');
    String nombreT = preferences.getString('nombreT');
    String apellidosT = preferences.getString('apellidosT');
    String telefonoT = preferences.getString('telefonoT');

    if(correo != null && nombreT != null && apellidosT != null && telefonoT != null){
      datos = true;
    }

    return datos;
  }

  /// Retorna el correo del taxista.
  /// Autor: Marco Venegas
  static Future<String> getSub() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('subT');
  }

  /// Retorna el nombre del taxista
  /// Autor: Valeria Zamora
  static Future<String> getNombre() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('nombreT');
  }

  /// Retorna los apellidos del taxista
  /// Autor: Valeria Zamora
  static Future<String> getApellidos() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('apellidosT');
  }

  /// Retorna el telefono del taxista
  /// Autor: Valeria Zamora
  static Future<String> getTelefono() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('telefonoT');
  }

  /// Retorna el Url de la foto del taxista.
  /// Autor: Marco Venegas
  static Future<String> getFotoUrl() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('fotoUrlT');
  }

  /// Retorna los permisos del taxista.
  /// Autor: Marco Venegas
  static Future<List<String>> getPermisos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList('permisosT');
  }

  /// Retorna el rol del taxista.
  /// Autor: Marco Venegas
  static Future<String> getRol() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('rolT');
  }

  /// Retorna el tiempo al que fue generado el token del taxista.
  /// Autor: Marco Venegas
  static Future<int> getIat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('iatT');
  }

  /// Retorna el momento del vencimiento del token del taxista.
  /// Autor: Marco Venegas
  static Future<int> getExp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('expT');
  }

  /// Retorna el nombre completo del taxista
  /// Autor: Valeria Zamora
  static Future<String> getnombreCompleto() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('nombreT') + ' ' + preferences.getString('apellidosT');
  }

  ///--------------------------------------------------------------------------
  /// Método que guarda los datos editados en el json en disco
  /// Autor: Joseph Rementería (b55824)
  static void editarJson(
    String nombreT,
    String apellidosT,
    String telefonoT,
    String correo
  ) async {
    ///------------------------------------------------------------------------
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ///------------------------------------------------------------------------
    await preferences.setString('correo', correo);
    await preferences.setString('nombreT', nombreT);
    await preferences.setString('apellidosT', apellidosT);
    await preferences.setString('telefonoT', telefonoT);
  }
  ///--------------------------------------------------------------------------
}
