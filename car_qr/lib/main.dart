import 'package:car_qr/carshowroom.dart';
import 'package:car_qr/myappbar.dart';
import 'package:car_qr/history.dart';
import 'package:car_qr/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Nav());
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
      },
    );
  }
}

class MyApp extends StatelessWidget {
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
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
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
              Center(
                child: Image(
                  image: AssetImage('assets/homelogo.png'),
                  height: 250.0,
                  width: 300.0,
                ),
              ),
              Center(
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
              ))
            ],
          )),
    );
  }
}
