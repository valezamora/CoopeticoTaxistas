import 'dart:async';
import 'package:CoopeticoTaxiApp/models/car_item.dart';
import 'package:CoopeticoTaxiApp/models/place_res.dart';
import 'package:CoopeticoTaxiApp/models/step_res.dart';
import 'package:CoopeticoTaxiApp/models/trip_info_res.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Autor: Paulo Barrantes.
/// Servicio encargado de hacer los http request a los distintos API de GoogleMaps.
///

class PlaceService {

  /// Método devuelve una lista de lugares usando una string como palabra clave
  /// utilizando el api de places de google maps
  ///
  /// Autor: Paulo Barrantes
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyDinfcLIRDycBUuW7ZMWFJlyVoOjFcshFI" +
            "&language=es&region=CR&query=" +
            Uri.encodeQueryComponent(keyword);

    print("search >>: " + url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }
  /// Método asincrono que usa el API de Directions para calcular las direcciones entre ubicaciones mediante una solicitud HTTP.
  ///
  /// Retorna una especie de promise o observable
  /// Autor: Paulo Barrantes
  static Future<dynamic> getStep( double lat, double lng, double tolat, double tolng ) async {
    String str_origin = "origin=" + lat.toString() + "," + lng.toString();
    // Destination of route
    String str_dest =
        "destination=" + tolat.toString() + "," + tolng.toString();
    // Sensor enabled
    String sensor = "sensor=false";
    String mode = "mode=driving";
    // Building the parameters to the web service
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    // Output format
    String output = "json";
    // Building the url to the web service
    String url = "https://maps.googleapis.com/maps/api/directions/" +
        output +
        "?" +
        parameters +
        "&key=AIzaSyDinfcLIRDycBUuW7ZMWFJlyVoOjFcshFI";

    print(url);
    final JsonDecoder _decoder = new JsonDecoder();
    return http.get(url).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
//      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(res);
      }


      TripInfoRes tripInfoRes;
      try {
        var json = _decoder.convert(res);
        int distance = json["routes"][0]["legs"][0]["distance"]["value"];
        List<StepsRes> steps =
        _parseSteps(json["routes"][0]["legs"][0]["steps"]);

        tripInfoRes = new TripInfoRes(distance, steps);

      } catch (e) {
        throw new Exception(res);
      }

      return tripInfoRes;
    });
  }

  /// Método privado para parsear el response del api de directions en StepRes
  /// Objeto creado para encapsular ese respuesta.
  ///
  /// Retorna una lista de StepRes
  ///
  /// Autor: Paulo Barrantes
  static List<StepsRes> _parseSteps(final responseBody) {
    var list = responseBody
        .map<StepsRes>((json) => new StepsRes.fromJson(json))
        .toList();

    return list;
  }
}