// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

class Response<T> {
  Response({
    this.success,
    this.message,
    this.resource,
    this.resourceList,
  });

  bool success;
  String message;
  dynamic resource;
  List<T> resourceList;

  /*
  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"],
        message: json["message"],
        resource: json["resource"],
        resourceList: List<ResourceList>.from(
            json["resourceList"].map((x) => ResourceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "resource": resource,
        "resourceList": List<dynamic>.from(resourceList.map((x) => x.toJson())),
      };
      */
}
