import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:CoopeticoTaxiApp/util/paleta.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';

class DrawerCustom extends Drawer {

  String email = '';
  String nombreCompleto = '';

  DrawerCustom(this.email, this.nombreCompleto);

  @override
  Widget build(BuildContext context) => new Drawer(

      child: ListView(
        children: <Widget>[

          new UserAccountsDrawerHeader(
            accountEmail: new Text(
                email ,
                style: TextStyle(color: Colors.white),

            ),
            accountName: new Text(
                nombreCompleto,
                style: TextStyle(color: Colors.white),
            ),

            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                  child:  Icon(Icons.person, color: Colors.black, size: 30.0),
                  backgroundColor: Colors.white
              ),
              onTap: () => Navigator.pushNamed(context, '/perfil'),
            ),
            decoration: BoxDecoration(
              color: Paleta.Naranja,
            ),
          ),
          new ListTile(
            title: new Text('Cerrar Sesión'),
            trailing: new Icon(Icons.exit_to_app),
            onTap: () {
              TokenService.borrarToken();
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],

      )
  );
}
