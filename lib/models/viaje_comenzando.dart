/// Clase para almacenar informacion de un viaje solicitado por un cliente
/// Autor: Valeria Zamora
class ViajeComenzando {
  String correoCliente;
  String origen;
  String destino;
  String tipo;
  bool datafono;
  List<String> taxistasQueRechazaron;

  ViajeComenzando(
    this.correoCliente,
    this.origen,
    this.destino,
    this.tipo,
    this.datafono,
    this.taxistasQueRechazaron
  );


}