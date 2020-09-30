import 'package:flutter/material.dart';
class Transaction {
  String detalles;
  double monto;
  DateTime fecha;
  //constructor
  Transaction({this.detalles, this.monto, this.fecha});
  @override
  String toString() {
    // TODO: implement toString
    return 'Detalles: $detalles, Monto: $monto';
  }
}