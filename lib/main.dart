import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/about.dart';
import 'package:car_qr/Screens/carshowroom.dart';
import 'package:car_qr/Screens/myappbar.dart';
import 'package:car_qr/Screens/history.dart';
import 'package:car_qr/Screens/signin.dart';
import 'package:car_qr/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Screens/car_description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Screens/admin_cars_screen.dart';

void main() {
  runApp(Nav());
}

class testApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AvailableCarsModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cars',
        theme: ThemeData.light(),
        home: AdminCarsPanal(),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => MyApp(),
        '/history': (context) => History(),
        '/signin': (context) => Signin(),
        '/showrooms': (context) => Carshowroom(),
        '/settings': (context) => Settings(),
        '/car_description': (context) => CarDetails(),
        '/about': (context) => About(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppstate createState() => _MyAppstate();
}

class _MyAppstate extends State<MyApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          titlex: new Text(
            'Car Showroom',
            style: TextStyle(fontSize: 22.0),
          ),
          history: () => Navigator.pushNamed(context, '/history'),
          showrooms: () => Navigator.pushNamed(context, '/showrooms'),
          settings: () => Navigator.pushNamed(context, '/settings'),
          about: () => Navigator.pushNamed(context, '/about'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: FadeTransition(
                opacity: animation,
                child: Text(
                  'All Your Car Details In Just A Scan',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(color: Colors.blue),
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: animation,
                child: Image(
                  image: AssetImage('assets/images/homelogo.png'),
                  height: 250.0,
                  width: 300.0,
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: animation,
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    'Start Scanning',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
            child: ListView(children: <Widget>[
          Container(
            height: 64.0,
            child: DrawerHeader(
              child: Text('Car Showroom'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Showrooms'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('History'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ])),
      ),
    );
  }
}
