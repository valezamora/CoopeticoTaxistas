import 'package:web_socket_channel/io.dart';
import 'package:CoopeticoTaxiApp/services/token_service.dart';

/// Clase para conectarse a web sockets
/// Autor: Valeria Zamora
class WebSocketsService {
  static IOWebSocketChannel connect(String url){
    var header = {
      'Authorization': 'Bearer ' + TokenService.getToken()
    };
    print('TOKEN: '+TokenService.getToken());
    return IOWebSocketChannel.connect(url, headers: header, protocols: ['stomp']);
  }
}