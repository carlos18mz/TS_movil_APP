import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model/transaction.dart';
import 'MoneyMovList.dart';


class MoneyMovView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MoneyMovView();
  }
}

class _MoneyMovView extends State<MoneyMovView> with WidgetsBindingObserver{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();


  Transaction _transaction = Transaction(detalles: '', monto: 0.0);
  List<Transaction> _transactions = List<Transaction>();

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
  void _insertTransaction() {

    if(_transaction.detalles.isEmpty ||
        _transaction.monto == 0.0 ||
        _transaction.monto.isNaN) {
      return;
    }
    _transaction.fecha = DateTime.now();
    _transactions.add(_transaction);
    _transaction = Transaction(detalles: '', monto: 0.0);
    _contentController.text = '';
    _amountController.text = '';
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: "Transacciones",
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Añadir transaccion'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    setState(() {
                      this._insertTransaction();
                    });
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Añadir transaccion',
              child: Icon(Icons.add),
              onPressed: (){
                setState(() {
                  this._insertTransaction();
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
                      decoration: InputDecoration(labelText: 'Contenido'),
                      controller: _contentController,
                      onChanged: (text) {
                        setState(() {
                          _transaction.detalles = text;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Cantidad'),
                      controller: _amountController,
                      onChanged: (text){
                        setState(() {
                          _transaction.monto = double.tryParse(text) ?? 0;//if error, value = 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        child: Text('Insertar Transaccion', style: const TextStyle(fontSize: 18),),
                        color: Colors.pinkAccent,

                        textColor: Colors.white,
                        onPressed: () {

                          setState(() {
                            this._insertTransaction();
                          });

                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('transaction list : '+_transactions.toString()),
                                duration: Duration(seconds: 3),
                              )
                          );

                        },
                      ),
                    ),
                    TransactionList(transactions: _transactions)
                  ],
                ),
              ),
            )
        )
    );
  }
}