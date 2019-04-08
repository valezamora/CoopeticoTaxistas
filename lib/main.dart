import 'package:flutter/material.dart';
import 'package:CoopeticoApp/routes.dart';
import 'package:CoopeticoApp/services/token_service.dart';
import 'package:CoopeticoApp/screens/login_usuario.dart';
import 'package:CoopeticoApp/screens/home.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  Widget home = new LoginUsuario();

  MyApp(){
    _setHome();
  }

  void _setHome() async{
    bool existeTokenValido = await TokenService.existeTokenValido();
    if(existeTokenValido){
      home = new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coopetico App',
      theme: new ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.white,
        fontFamily: "Roboto"
      ),
      home: home,
      routes: routes,
      //home: LoginUsuario(titulo: "Login Usuario.")//RandomWords(),
    );
  }
}