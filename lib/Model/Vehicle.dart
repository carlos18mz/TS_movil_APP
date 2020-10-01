import 'dart:ffi';

class Vehicle {
  final String driver;
  final String model;
  final String brand;
  final Double loadingCapacity;

  Vehicle({this.driver, this.model, this.brand, this.loadingCapacity});

  factory Vehicle.fromJson(Map<String, dynamic> map) {
    return Vehicle(
      driver: map['driver'],
      model: map['model'],
      brand: map['brand'],
      loadingCapacity: map['loadingCapacity'],
    );
  }
}