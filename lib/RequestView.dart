import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model/request.dart';
import 'RequestList.dart';


class RequestView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RequestView();
  }
}

class _RequestView extends State<RequestView> with WidgetsBindingObserver{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _cargoController = TextEditingController();
  final _amountController = TextEditingController();
  final _clientController = TextEditingController();
  final _distanceController = TextEditingController();


  Request _request = Request(carga: '', cantidad: 0.0, solicitante: '', distancia: 0.0);
  List<Request> _requests = List<Request>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

  }
  void _insertRequest() {

    if(_request.solicitante.isEmpty || _request.cantidad == 0.0 || _request.carga.isEmpty || _request.distancia.isNaN || _request.distancia == 0.0|| _request.cantidad.isNaN) {
      return;
    }
    _request.fecha = DateTime.now();
    _requests.add(_request);
    _request = Request(carga: '', cantidad: 0.0, solicitante: '', distancia: 0.0);
    _cargoController.text = '';
    _amountController.text = '';
    _clientController.text = '';
    _distanceController.text = '';
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: "Solicitudes",
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Añadir solicitud'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed: (){
                    setState(() {
                      this._insertRequest();
                    });
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Añadir solicitud',
              child: Icon(Icons.add),
              onPressed: (){
                setState(() {
                  this._insertRequest();
                });
              },
            ),
            key: _scaffoldKey,
            body: SafeArea(
              minimum: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Solicitante'),
                      controller: _clientController,
                      onChanged: (text) {
                        setState(() {
                          _request.solicitante = text;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Carga'),
                      controller: _cargoController,
                      onChanged: (text){
                        setState(() {
                          _request.carga = text;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Cantidad'),
                      controller: _amountController,
                      onChanged: (text){
                        setState(() {
                          _request.cantidad = double.tryParse(text) ?? 0;//if error, value = 0
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Distancia'),
                      controller: _distanceController,
                      onChanged: (text){
                        setState(() {
                          _request.distancia = double.tryParse(text) ?? 0;//if error, value = 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        child: Text('Insertar Solicitud', style: const TextStyle(fontSize: 18),),
                        color: Colors.blueGrey,

                        textColor: Colors.white,
                        onPressed: () {

                          setState(() {
                            this._insertRequest();
                          });

                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('request list : '+_requests.toString()),
                                duration: Duration(seconds: 3),
                              )
                          );

                        },
                      ),
                    ),
                    RequestList(requests: _requests)
                  ],
                ),
              ),
            )
        )
    );
  }
}