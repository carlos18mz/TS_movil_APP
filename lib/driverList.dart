import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DriverList();
}

class _DriverList extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Lista de conductores'),
      ),
    );
  }
}
