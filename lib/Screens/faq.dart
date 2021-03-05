import 'package:flutter/material.dart';

void main() {
  runApp(FAQ());
}

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(padding: const EdgeInsets.all(10), children: <Widget>[
        Center(
          child: Column(children: <Widget>[
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "What is the idea of the application?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Scan QR code of the car to view its description",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                ],
              ),
            ),

            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "How to add cars to your showroom?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Open admin panel then add car to your showroom",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  
                ],
              ),
            ),

            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Can you see prices from different showrooms?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Yes, you can navigate throw different showrooms to see different prices",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  
                ],
              ),
            ),

            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "How can i know if a specific car is good or not?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "You can see reviews of cars from different users",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  
                ],
              ),
            ),

            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Do we collect your personal information?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  
                ],
              ),
            ),
            
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(1.0, 5.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "How to generate QR code for a car?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Add the car to your showroom then press on the generate QR code button",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  
                ],
              ),
            ),

          ]),
        ),
      ]),
    );
  }
}

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
}
