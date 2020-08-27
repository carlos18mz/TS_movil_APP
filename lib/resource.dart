import 'package:flutter/foundation.dart';

class Resource {
  final bool success;
  final String message;
  final Map resource;
  final Map resourceList;

  Resource({
    @required this.success,
    @required this.message,
    @required this.resource,
    @required this.resourceList,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      success: json['success'],
      message: json['message'],
      resource: json['resource'],
      resourceList: json['resourceList'],
    );
  }
}
