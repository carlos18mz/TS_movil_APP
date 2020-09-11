//import 'package:TropsSmart/Authentication.dart';
import 'package:TropSmart/Model/Cargo.dart';
import 'package:TropSmart/Model/Favorite.dart';
import 'package:TropSmart/resource.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Model/Driver.dart';

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
    //debugPrint(email);
    var body = json.encode(obj);

    final response = await http.post("$apiUrl" + "api/authentication/sign-in",
        body: body, headers: {"Content-Type": "application/json"});

    var data = json.decode(response.body);
    return data;
  }

  Future getDrivers() async {
    final response =
        await http.get("$apiUrl" + "api/drivers", headers: this.headers);

    var data = json.decode(response.body);
    return data;
  }

  Future<List<Cargo>> getCargoes() async {
    try {
      final response =
          await http.get("$apiUrl" + "api/cargoes", headers: this.headers);
      if (response.statusCode == 200) {
        debugPrint("Status code 200");
        String responseBody = response.body;
        //Map<String, dynamic> decoded = json.decode(responseBody.trim());
        //List<Cargo> cargoList = List<Cargo>.from(
        //    decoded['resourceList'].map((x) => Cargo.fromJson(x)));

        var tagsJosn = jsonDecode(responseBody)['resourceList'] as List;
        List<Cargo> c = tagsJosn.map((tagJ) => Cargo.fromJson(tagJ)).toList();

        debugPrint("tagsJson :");
        for (var k in c) {
          debugPrint("VALUEEE : " + k.driver);
        }

        Map<String, dynamic> decoded = json.decode(responseBody.trim());
        List<Cargo> cargoList = List<Cargo>.from(
            decoded['resourceList'].map((x) => Cargo.fromJson(x)));

        debugPrint("return cargoList size ");
        debugPrint("return cargoList size " + cargoList.length.toString());
        return cargoList;
      }
      return null;
    } catch (e) {
      return List<Cargo>();
    }
  }

  Future<List<Favorite>> getFavorites() async {
    try {
      final response = await http.get("$apiUrl" + "api/users/favorites",
          headers: this.headers);
      if (response.statusCode == 200) {
        String responseBody = response.body;

        Map<String, dynamic> decoded = json.decode(responseBody.trim());
        List<Favorite> favoriteList = List<Favorite>.from(
            decoded['resourceList'].map((x) => Favorite.fromJson(x)));
        return favoriteList;
      }
      return null;
    } catch (e) {
      return List<Favorite>();
    }
  }

  Future<List<Driver>> getDriversfixed() async {
    try {
      final response =
          await http.get("$apiUrl" + "api/drivers", headers: this.headers);
      if (response.statusCode == 200) {
        String responseBody = response.body;
        Map<String, dynamic> decoded = json.decode(responseBody.trim());
        List<Driver> driverList = List<Driver>.from(
            decoded['resourceList'].map((x) => Driver.fromJson(x)));

        return driverList;
      }
      return null;
    } catch (e) {
      return List<Driver>();
    }
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
