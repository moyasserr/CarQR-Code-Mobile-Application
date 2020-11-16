import 'package:car_qr/myappbar.dart';
import 'package:flutter/material.dart';

class Carshowroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          titlex: new Text(
            'Car Showrooms',
            style: TextStyle(fontSize: 22.0),
          ),
          history: () => Navigator.pushNamed(context, '/history'),
          showrooms: () => Navigator.pushNamed(context, '/showrooms'),
          settings: () => Navigator.pushNamed(context, '/settings'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              for (var i = 0; i <= 5; i++) Car(),
            ],
          ),
        ),
      ),
    );
  }
}

class Car extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black45),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 30.0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.black),
              image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'), fit: BoxFit.fill),
            ),
          ),
          Text('Car Showroom',
              style: TextStyle(fontSize: 25, color: Colors.blue)),
        ],
      ),
    );
  }
}
