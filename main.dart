import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Color.fromRGBO(99, 190, 220, 1),
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2, color: Color.fromRGBO(32, 150, 243, 1)),
                  image: DecorationImage(
                      image: AssetImage('assets/logo.jpg'), fit: BoxFit.fill),
                ),
              ),
              Text('Car Showroom',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              Container(
                margin: const EdgeInsets.only(left: 100.0),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        body: Center(
          child: Image(
            image: AssetImage('assets/homelogo.png'),
            height: 250.0,
            width: 300.0,
          ),
        ),
      ),
    );
  }
}
