import 'package:car_qr/myappbar.dart';
import 'package:flutter/material.dart';

class Carshowroomadmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          titlex: new Text(
            'Showroom Admin Panel',
            style: TextStyle(fontSize: 22.0),
          ),
          history: () => Navigator.pushNamed(context, '/history'),
          showrooms: () => Navigator.pushNamed(context, '/showrooms'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    onPressed: null,
                    child: Text('ADD',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  FlatButton(
                      onPressed: null,
                      child: Text('EDIT',
                          style: TextStyle(fontSize: 20, color: Colors.black))),
                ],
              ),
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
                  image: AssetImage('assets/porsche.png'), fit: BoxFit.fill),
            ),
          ),
          Text('Car Details',
              style: TextStyle(fontSize: 25, color: Colors.blue)),
        ],
      ),
    );
  }
}
