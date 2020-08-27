import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RequestList();
}

class Users {
  String id;
  String title;
  String subtitle;

  Users({this.id, this.title, this.subtitle});
}

class _RequestList extends State<RequestList> {
  List requestList = [
    Users(id: "1", title: "Saco de papa", subtitle: "S/. 415"),
    Users(id: "2", title: "Autopartes x100", subtitle: "S/. 300"),
    Users(id: "3", title: "Cura del covid", subtitle: "S/. 250"),
    Users(id: "4", title: "Accesorios", subtitle: "S/. 500"),
    Users(id: "5", title: "Techo calamina", subtitle: "S/. 670"),
    Users(id: "6", title: "Mesa de billar", subtitle: "S/. 730"),
    Users(id: "7", title: "Avion a escala", subtitle: "S/. 200"),
    Users(id: "8", title: "Harto sillao", subtitle: "S/. 120"),
    Users(id: "9", title: "Xiaomi calidad precio", subtitle: "S/. 330"),
    Users(id: "10", title: "C", subtitle: "S/. 350"),
  ];

  @override
  Widget build(BuildContext context) {
    /*return new Scaffold(
      body: Center(child: ListView.builder(
          //itemCount: userList
          itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(userList[index].title),
          subtitle: Text(userList[index].subtitle),
        );
      })),
    );*/

    return ListView.builder(
        itemCount: requestList.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
              title: Text(requestList[i].title),
              subtitle: Text(requestList[i].subtitle));
        });
  }
}
