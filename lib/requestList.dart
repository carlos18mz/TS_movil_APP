
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'Model/request.dart';

class RequestList extends StatelessWidget{
  final List<Request> requests;

  RequestList({this.requests});
  ListView _buildListView() {
    return ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index){
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: (index) % 2 == 0 ? Colors.lightGreen : Colors.tealAccent,
              elevation: 10,


            //this lesson will customize this ListItem, using Column and Row

            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top:10)),
                      Text(requests[index].carga,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white
                        ),
                      ),
                      Text('Date: ${DateFormat.yMd().format(requests[index].fecha)}',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                      Padding(padding: EdgeInsets.only(bottom:10)),
                    ],
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${requests[index].cantidad}\kg',
                                style: TextStyle(fontSize: 12, color: Colors.white)),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
                                borderRadius:BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10),)
                        ],
                      )
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${requests[index].solicitante}',
                                style: TextStyle(fontSize: 12, color: Colors.white)),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
                                borderRadius:BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10),)
                        ],
                      )
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${requests[index].distancia}\km',
                                style: TextStyle(fontSize: 12, color: Colors.white)),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
                                borderRadius:BorderRadius.all(Radius.circular(10))
                            ),

                          ),
                          Padding(padding: EdgeInsets.only(right: 10),)
                        ],
                      )
                  ),
                  Row(
                      children: <Widget>[
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              color: const Color(0x406204EE),
                              textColor: const Color(0xFF6200EE),
                              onPressed: () {
                                requests[index].estado = true;
                              },
                              child: const Text('Aceptar'),
                            ),
                            FlatButton(
                              color: const Color(0x406204EE),
                              textColor: const Color(0xFF6200EE),
                              onPressed: () {
                                requests[index].estado = false;
                              },
                              child: const Text('Rechazar'),
                            ),
                          ],
                        ),
                      ],
                  )




                ],



              ),





          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 400,
        child: _buildListView()
    );
  }
}