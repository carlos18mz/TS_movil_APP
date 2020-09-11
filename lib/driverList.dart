import 'package:TropSmart/Model/Driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TropSmart/http-service.dart';

class DriverList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DriverList();
}

class _DriverList extends State<DriverList> {
  List<Driver> drivers;
  final HttpService httpService = HttpService();

  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;

    httpService.getDriversfixed().then((list) => {
          setState(() {
            drivers = list;
            loading = false;
          })
        });
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
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  //Driver driver = drivers[index];
                  return DriverCard(context, index);
                  //return CustomListTile(Text(driver.firstName),
                  //    Text(driver.lastName), Text(driver.license));
                })));
  }
}

/*
class _DriverList extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Note tile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
 */
