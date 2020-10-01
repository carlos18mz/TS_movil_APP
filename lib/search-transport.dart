import 'dart:convert';
import 'package:TropSmart/Model/Driver.dart';
import 'package:TropSmart/Model/Vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data/data_constants.dart';

class SearchTransport extends StatefulWidget{
  @override
  _SearchTransportPage createState() => _SearchTransportPage();
}

class _SearchTransportPage extends State<SearchTransport> {
  List<Vehicle> vehicles = [];

  void onChangedText(String text) {
    requestSearch(text);
    //print('text : $text');
  }

 void requestSearch(String text) async {
   final url = "$api/api/vehicles/$text";
   final response = await http.get(url);
   final data = jsonDecode(response.body) as List;
   setState(() {
     vehicles = data.map((e) => Vehicle.fromJson(e)).toList();
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: TextField(
                onChanged: onChangedText,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'Buscar Transportista',
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  )
                )
              ),
            ),
            const SizedBox(
            height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index){
                  final vehicle = vehicles[index];
                  return ListTile(
                    title: Text(vehicle.driver),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                      )
                    )
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}