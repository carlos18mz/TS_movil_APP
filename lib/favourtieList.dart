import 'package:TropSmart/Model/Driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TropSmart/http-service.dart';

class FavoriteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouriteList();
}

class _FavouriteList extends State<FavoriteList> {
  final HttpService httpService = HttpService();
  List<Driver> drivers;

  Future<List<Driver>> getDrivers() async {
    this.drivers = await httpService.getDriversfixed();
    return this.drivers;
  }

  Widget DriverCard(BuildContext context, int index) {
    final driver = drivers[index];
    return new Container(
        child: Card(
            child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(driver.firstName),
            Text(driver.lastName),
            Text(driver.license)
          ],
        )
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            child: FutureBuilder(
                future: getDrivers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DriverCard(context, index);
                        });
                  }
                })));
  }
}
