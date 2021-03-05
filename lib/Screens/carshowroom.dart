import 'package:car_qr/Screens/showroom_details.dart';
import 'package:flutter/material.dart';

class Carshowroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: new Text(
            'Car Showrooms',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              for (var i = 0; i <= 5; i++) Cars(),
            ],
          ),
        ),
      ),
    );
  }
}

class Cars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Showroomdetails();
          }));
        },
        child: Container(
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
                offset: Offset(0, 3),
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
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              Text('Car Showroom',
                  style: TextStyle(fontSize: 25, color: Colors.blue)),
            ],
          ),
        ));
  }
}
