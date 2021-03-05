import 'package:flutter/material.dart';

void main() {
  runApp(ContactUs());
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: ListView(padding: const EdgeInsets.all(30), children: <Widget>[
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
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Mohamed Yasser"),
                    onTap: () {
                      //open change password
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "mohamedyasser9620@gmail.com",
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(
                      Icons.link,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "github.com/moyasser",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      //open change language
                    },
                  ),
                  
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
