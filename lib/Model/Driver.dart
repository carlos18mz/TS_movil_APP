// To parse this JSON data, do
//
//     final driver = driverFromJson(jsonString);

import 'dart:convert';

List<Driver> driverFromJson(String str) =>
    List<Driver>.from(json.decode(str).map((x) => Driver.fromJson(x)));

String driverToJson(List<Driver> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Driver {
  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.license,
  });

  int id;
  String firstName;
  String lastName;
  String license;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        license: json["license"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "license": license,
      };
}
