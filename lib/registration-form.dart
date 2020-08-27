import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  //String value;
  //RegistrationForm(this.value);

  @override
  State<StatefulWidget> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Registration form"),
    ));
  }
}
