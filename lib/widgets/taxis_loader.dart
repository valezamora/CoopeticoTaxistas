import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/// Autor: Marco Venegas.
/// Widget Animado. Dos taxis que vienen y van :D
class TaxisLoader extends StatefulWidget {

  TaxisLoader() : super();

  @override
  _TaxisLoaderState createState() => _TaxisLoaderState();
}

class _TaxisLoaderState extends State<TaxisLoader> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        children: <Widget>[
          new FlareActor(
            'assets/Loading.flr',
            alignment: Alignment.center,
            animation: 'Loading',
          )
        ],
      ),
    );
  }
}