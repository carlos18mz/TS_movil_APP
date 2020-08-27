//import 'package:TropsSmart/Authentication.dart';
import 'package:TropSmart/resource.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = "https://ts-opensource-be.herokuapp.com/";

  Map<String, String> headers = {"Content-type": "application/json"};

  Future<void> deleteUser(int id) async {
    var res = await http.delete("$apiUrl/$id");

    if (res.statusCode == 200) {
      print("Deleted");
    }
  }

  Future<Resource> getUser(int id) async {
    var res = await http.get("$apiUrl" + "api/users/$id");

    if (res.statusCode == 200) {
      print(res.body);
      return Resource.fromJson(json.decode(res.body));
    } else {
      throw 'cant get users';
    }
  }

  Future signIn(String email, String password) async {
    Map obj = {
      'email': email,
      'password': password,
    };

    debugPrint(email);
    var body = json.encode(obj);

    final response = await http.post("$apiUrl" + "api/authentication/sign-in",
        body: body, headers: {"Content-Type": "application/json"});

    var data = json.decode(response.body);

    return data;
  }

  Future<List<Resource>> getUsers() async {
    final res = await http.get(apiUrl + "api/users");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Resource> users =
          body.map((dynamic item) => Resource.fromJson(item)).toList();

      return users;
    } else {
      throw 'cant get post.';
    }
  }
}
