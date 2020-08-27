import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'http-service.dart';

class PostPage extends StatefulWidget {
  final HttpService httpService = HttpService();

  @override
  State<StatefulWidget> createState() => _HomePageState();
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post'),
        ),
        body: FutureBuilder(
          future: httpService.signIn("carlos18@gmail.com", "123456"),
          /*builder:
              (BuildContext context, AsyncSnapshot<List<Resource>> snapshot) {
            if (snapshot.hasData) {
              List<Resource> resources = snapshot.data;
              print(resources);
              return ListView(
                children: resources
                    .map(
                      (Resource resource) => ListTile(
                        title: Text(resource.success.toString()),
                        subtitle: Text(
                          resource.message.toString(),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),*/
          builder: (BuildContext context, AsyncSnapshot<Resource> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.resource.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
  }
*/

}

class _HomePageState extends State<PostPage> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response =
        await http.get("https://ts-opensource-be.herokuapp.com/api/users");
    data = json.decode(response.body);
    setState(() {
      userData = data["resourceList"];
    });
    debugPrint(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Friends"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(
                    "${userData[index]['firstName']} ${userData[index]['lastName']}"),
              ],
            ),
          ));
        },
      ),
    );
  }
}

/*

{
  "success":true,
  "message":"Success",
  "resource":null,
  "resourceList": [
    {
      "email":"carlos18@gmail.com",
      "password":"123456",
      "firstName":"Carlos Alberto",
      "lastName":"Mamani ZuÃ±iga",
      "role":"Customer"
    }
  ]
}

*/
