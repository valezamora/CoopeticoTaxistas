
class Network{
  static const IP_BACKEND = "192.168.1.6";
  static const PORT_BACKEND = "8080";

  static String getFullUrlBackend(){
    const String url = "http://" + IP_BACKEND +":" + PORT_BACKEND;
    return url;
  }
}