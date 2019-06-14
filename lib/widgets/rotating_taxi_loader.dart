import 'package:flutter/material.dart';

/// Autor: Marco Venegas.
/// Widget Animado. Taxi giratorio.
class RotatingTaxiLoader extends StatefulWidget {

  RotatingTaxiLoader() : super();

  @override
  _RotatingTaxiLoaderState createState() => _RotatingTaxiLoaderState();
}

class _RotatingTaxiLoaderState extends State<RotatingTaxiLoader> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    controller.repeat();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          new RotationTransition(
            turns: animation,
            child: Image.asset(
              'assets/taxi.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}