import 'package:flutter/material.dart';
class Request {
  String solicitante;
  double cantidad;
  String carga;
  double distancia;
  DateTime fecha;

  bool estado;
  //constructor
  Request({this.solicitante, this.cantidad, this.carga, this.distancia, this.fecha});
  @override
  String toString() {
    // TODO: implement toString
    return 'Solicitante: $solicitante, Cantidad: $cantidad, Carga: $carga, Distancia: $distancia';
  }
}