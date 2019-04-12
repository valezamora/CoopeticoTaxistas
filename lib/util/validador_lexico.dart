
/// Autor: Marco Venegas.
///
/// Clase con métodos estáticos para realizar validaciones de entradas de texto.
class ValidadorLexico{
  static final String _regExpCorreo =
      r"^([a-zA-Z0-9_\-\.]+)\@([a-zA-Z0-9_\-]+)\.([a-zA-Z]{2,5})$";
  static final String _regExpContrasena = r"^[^(\-\-|\;|\—)]+$";

  /// [value] contiene el correo al que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  static String validarCorreo(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Por favor ingrese su correo.";
    } else {
      RegExp regExp = new RegExp(_regExpCorreo);
      if (!regExp.hasMatch(value)) {
        mensajeError = "Correo inválido.";
      } else {
        mensajeError = null;
      }
    }
    return mensajeError;
  }

  /// [value] contiene la contraseña a la que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  /// No se permiten contraseñas con '--' o ';'.
  static String validarContrasena(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Por favor ingrese su contraseña.";
    } else {
      RegExp regExp = new RegExp(_regExpContrasena);
      if (!regExp.hasMatch(value)) {
        mensajeError = "Contraseña inválida.";
      } else {
        mensajeError = null;
      }
    }
    return mensajeError;
  }
}

