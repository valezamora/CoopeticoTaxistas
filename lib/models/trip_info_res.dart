import 'package:CoopeticoTaxiApp/models/step_res.dart';
/// Autor: Paulo Barrantes.
/// Clase encargada de encapsular en un objeto la información del viaje
///
///
class TripInfoRes {
  final int distance; // met
  final List<StepsRes> steps;

  TripInfoRes(this.distance, this.steps);
}