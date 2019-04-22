
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
        final matches = regExp.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            mensajeError = null;
          } else {
            mensajeError = "Correo inválido.";
          }
        }
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
        final matches = regExp.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            mensajeError = null;
          } else {
            mensajeError = "Contraseña inválida.";
          }
        }
      }
    }
    return mensajeError;
  }

  /// [value] contiene el nombre al que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  /// Los nombres solamente pueden contener letras.
  /// Autor: Valeria Zamora
  static String validarNombre(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Ingrese su nombre.";
    } else {
      RegExp regExp = new RegExp(r"[A-Za-z\s]+");
      if (!regExp.hasMatch(value)) {
        mensajeError = "Nombre inválido.";
      } else {
        final matches = regExp.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            mensajeError = null;
          } else {
            mensajeError = "Nombre inválido.";
          }
        }
      }
    }
    return mensajeError;
  }

  /// [value] contiene los apellidos a los que se les desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  /// Los apellidos solamente pueden contener letras.
  /// Autor: Valeria Zamora
  static String validarApellido(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Ingrese su apellido.";
    } else {
      RegExp regExp = new RegExp(r"[A-Za-z\s]+");
      if (!regExp.hasMatch(value)) {
        mensajeError = "Apellido inválido.";
      } else {
        final matches = regExp.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            mensajeError = null;
          } else {
            mensajeError = "Apellido inválido.";
          }
        }
      }
    }
    return mensajeError;
  }

  /// [value] contiene el telefono al que se le desea validar el formato.
  /// Se utiliza una expresión regular para validar dicho formato.
  /// Los telefonos solamente pueden contener 8 números.
  /// Autor: Valeria Zamora
  static String validarTelefono(String value) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Ingrese su teléfono.";
    } else {
      RegExp regExp = new RegExp(r"[0-9]{8}");
      if(!regExp.hasMatch(value)){
        mensajeError = "Teléfono inválido.";
      } else {
        final matches = regExp.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            mensajeError = null;
          } else {
            mensajeError = "Teléfono inválido.";
          }
        }
      }
    }
    return mensajeError;
  }

  /// [value] contiene la contraseña al que se le desea validar el formato.
  /// [con] contiene la contraseña ingresada anteriormente.
  /// Se valida que ambas sean iguales.
  /// Autor: Valeria Zamora
  static String validarContrasenaValidada(String value, String con) {
    var mensajeError = '';
    if (value.isEmpty) {
      mensajeError = "Ingrese su contraseña.";
    } else {
      if (value != con) {
        mensajeError = "Verifique la contraseña ingresada.";
      } else {
        mensajeError = null;
      }
    }
    return mensajeError;
  }
}

