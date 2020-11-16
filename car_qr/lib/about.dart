import 'package:flutter/material.dart';
import 'package:car_qr/myappbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_qr/app_info.dart';

void main() {
  runApp(About());
}
class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => About(),
        '/app_info': (context) => AppInfo(),
      },
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
            titlex: new Text(
              'Help',
              style: TextStyle(fontSize: 22.0),
            ),
            history: () => Navigator.pushNamed(context, '/history'),
            showrooms: () => Navigator.pushNamed(context, '/showrooms'),
          ),
          
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 35.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.question_answer,
                            color: Colors.blue,
                          ),
                          title: Text("FAQ"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),
                          title: Text("Contact Us"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                            leading: Icon(
                            FontAwesomeIcons.fileContract,
                            color: Colors.blue,
                          ),
                            title: Text("Terms and Conditions"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {}),
                        _buildDivider(),
                        GestureDetector(onTap: () {Navigator.pushNamed(context, '/app_info'
                            );},
                            child:
                        ListTile(
                            leading: Icon(
                            FontAwesomeIcons.infoCircle,
                            color: Colors.blue,
                          ),
                            title: Text("App Info"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            
                            
                            )
                        )
                          
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
}