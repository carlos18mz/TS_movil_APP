import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
