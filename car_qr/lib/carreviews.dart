import 'package:flutter/material.dart';

class Carreviews extends StatelessWidget {
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
        body: SafeArea(
            child: Column(
          children: [
            for (var i = 0; i <= 3; i++) SingleReview(),
            Container(
              padding: EdgeInsets.only(left: 175),
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                },
                label: Text('Add your comment'),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class SingleReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 175.0),
                child: Text(
                  '7/10',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.blue),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Comments on the Car',
                    style: TextStyle(fontSize: 20, color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
