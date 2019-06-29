/// Clase para almacenar informacion de un viaje solicitado por un cliente
/// Autor: Valeria Zamora
class ViajeComenzando {
  String correoCliente;
  String origen;
  String destino;
  String tipo;
  bool datafono = false;
  List taxistasQueRechazaron;

  ViajeComenzando(
    this.correoCliente,
    this.origen,
    this.destino,
    this.taxistasQueRechazaron,
    this.datafono,
    this.tipo
  );


}