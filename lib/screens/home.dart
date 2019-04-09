import 'package:flutter/widgets.dart';
import 'package:CoopeticoApp/widgets/boton.dart';
import 'package:CoopeticoApp/services/token_service.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFFFFFFFF),
      child: Boton(
        'Cerrar sesión',
        Color(0xFF000000),
        Color(0xFFFFFFFF),
        onPressed: (){
          TokenService.borrarToken();
          Navigator.of(context).pushReplacementNamed('/login');
        },
      )
      );

  }
}