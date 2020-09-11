import 'package:TropSmart/dashboard.dart';
import 'package:TropSmart/http-service.dart';
import 'package:TropSmart/transitions.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'http-service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'TropSmart verison móvil';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  VideoPlayerController _controller;
  final HttpService httpService = HttpService();
  var formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;
  CustomTransition customTransition = CustomTransition();

  //=========VIDEO BACKGROUND ===================================

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://ak.picdn.net/shutterstock/videos/1054507820/preview/stock-footage-one-semi-truck-with-white-trailer-and-cab-driving-traveling-alone-on-dense-flat-forest-asphalt.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.width ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : login(),
          ),
        ],
      ),
    );
  }

  /*SlideTransition customTransition(animation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }*/

  Container login() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 150, 10, 150),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Card(
        margin: const EdgeInsets.fromLTRB(30, 45, 30, 45),
        //margin: const EdgeInsets.fromLTRB(30, 180, 30, 180),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: (Form(
          key: formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    margin: new EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (input) =>
                              !input.contains('@') ? 'Email no valido' : null,
                          onSaved: (input) => _email = input,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Contraseña'),
                          validator: (input) => input.length < 6
                              ? 'Necesitas 6 caráteres como minimo'
                              : null,
                          onSaved: (newValue) => _password = newValue,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Entrar'),
                          onPressed: () {
                            formKey.currentState.save();
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(_email, _password, context);
                          },
                        ),
                        FlatButton(
                            child: Text('Registrarse'),
                            onPressed: () {
                              //Navigator.of(context).push(MaterialPageRoute(
                              //builder: (context) => RegistrationForm(),
                              //)
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      Dashboard(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return customTransition.getTransition(
                                        animation, child);
                                  }));
                            })
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void signIn(String email, String password, context) async {
    var response = await httpService.signIn("carlos@gmail.com", "123456");
    //print(json.encode(response));
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (response['success'] == true) {
      //SHARED PREFERENCES
      /*setState(() {
        sharedPreferences.setString("token", response['resource']['token']);
      });*/
      //SharedPreferences.setString("token", response.id);
      _isLoading = false;
      debugPrint("Success");

      //Navigator.of(context).pushAndRemoveUntil(
      //    MaterialPageRoute(builder: (context) => Dashboard()),
      //    (Route<dynamic> route) => false);

      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return customTransition.getTransition(animation, child);
          }));
    } else {
      debugPrint("Failed");
      _isLoading = false;
    }
  }
}

//NAVIGATION DRAWER

//================LOGIN==================================

/*
Future login() async {
  http.Response response = await http.get(
      "https://ts-opensource-be.herokuapp.com/api/authentication/carlos18@gmail.com/${_password}");
  var data = json.decode(response.body);
  if (data['success'] == true) {
    print(data);
    debugPrint("User authenticated");
    var authUser = data['resource'];
    return authUser;
    //User Authenticated
  } else {
    throw Exception('Failed to load data');
  }
}

StatefulWidget newPage() {}

void endingfor() {
  debugPrint("THE END");
}

*/

/*FutureBuilder<Resource>(
                              future: httpService.signIn(_email, _password),
                              // ignore: missing_return
                              builder: (BuildContext context,
                                  AsyncSnapshot<Resource> snapshot) {
                                if (snapshot.hasData) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => dashboard()));
                                }
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  debugPrint("Waiting");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return dashboard();
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            );*/
