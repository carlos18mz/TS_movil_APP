import 'package:TropSmart/http-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TropSmart/Model/Cargo.dart';

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
  final HttpService httpService = HttpService();
  List<Cargo> cargoes;

  Future<List<Cargo>> getCargoes() async {
    this.cargoes = await httpService.getCargoes();
    return this.cargoes;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            child: FutureBuilder(
                future: getCargoes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Cargo getCargo = snapshot.data[index];
                          return CustomListTile(
                              Text(getCargo.customer),
                              Text(getCargo.description),
                              Text(getCargo.cargoStatus));
                        });
                  }
                })));
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
  }
  /*List requestList = [
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
          return CustomListTile(Text(requestList[i].id),
              Text(requestList[i].title), Text(requestList[i].subtitle));
        });
  }
*/

}

class CustomListTile extends StatelessWidget {
  Text col1;
  Text col2;
  Text col3;

  CustomListTile(col1, col2, col3) {
    this.col1 = col1;
    this.col2 = col2;
    this.col3 = col3;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: Colors.lightBlue[200],
        child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[col1, col2, col3],
            )));
  }
}
