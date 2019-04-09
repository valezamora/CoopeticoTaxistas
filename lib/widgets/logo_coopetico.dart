import 'package:flutter/widgets.dart';

/// Widget reutilizable con el logo de CoopeTico.
class LogoCoopetico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo-coopetico.png',
      width: 250.0,
      height: 58.55,
    );
  }
}
