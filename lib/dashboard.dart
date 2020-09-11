import 'package:TropSmart/DriverList.dart';
import 'package:TropSmart/favourtieList.dart';
import 'package:TropSmart/main.dart';
import 'package:TropSmart/transitions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RequestList.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashBoard();
}

class _DashBoard extends State<Dashboard> {
  int _currentPage = 0;
  SharedPreferences sharedPreferences;
  CustomTransition customTransition = CustomTransition();

  final List<Widget> _navPages = [
    RequestList(),
    DriverList(),
    FavoriteList(),
  ];

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    /*if (sharedPreferences.getString('token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }*/
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

/*
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Business', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  //================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DashBoard'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Log out',
                //onPressed: scaffoldKey.currentState.showSnachBar(snackBar);
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LoginPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return customTransition.getTransition(animation, child);
                      }));
                })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: false,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/74.jpg",
                          scale: 0.3),
                    ),
                    Text("Carlos Alberto"),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://media.istockphoto.com/photos/blue-abstract-background-or-texture-picture-id1138395421?k=6&m=1138395421&s=612x612&w=0&h=bJ1SRWujCgg3QWzkGPgaRiArNYohPl7-Wc4p_Fa_cyA='),
                  fit: BoxFit.fill,
                )
                    //color: Colors.lightBlue[400],
                    ),
              ),
              CustomDrawTile(Icon(Icons.dashboard), Text('Dashboard'),
                  Icon(Icons.arrow_right)),
              CustomDrawTile(
                  Icon(Icons.person), Text('Perfil'), Icon(Icons.arrow_right)),
              CustomDrawTile(Icon(Icons.credit_card), Text('Comprar créditos'),
                  Icon(Icons.arrow_right)),
              CustomDrawTile(Icon(Icons.settings),
                  Text('Configuración de la cuenta'), Icon(Icons.arrow_right)),
              CustomDrawTile(Icon(Icons.monetization_on),
                  Text('Planes de subscripcion'), Icon(Icons.arrow_right)),

              /*ListTile(
                Icon(Icons.dashboard),
                Text('Perfil'),
                Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                Icon(Icons.person),
                Text('Perfil'),
                Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                Icon(Icons.credit_card),
                Text('Compra de créditos'),
                Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                Icon(Icons.settings),
                Text('Configuracion'),
                Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pop(context);
                },
              ),*/
            ],
          ),
        ),
        body: _navPages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            )
          ],
          currentIndex: _currentPage,
          selectedItemColor: Colors.lightBlue[800],
          onTap: _onItemTapped,
        ));
  }
}

class CustomDrawTile extends StatelessWidget {
  Icon icon1, icon2;
  Text title;
  CustomDrawTile(icon1, title, icon2) {
    this.icon1 = icon1;
    this.icon2 = icon2;
    this.title = title;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: Colors.lightBlue[200],
        child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    icon1,
                    Text('  '),
                    title,
                  ],
                ),
                icon2,
              ],
            )));
  }
}
