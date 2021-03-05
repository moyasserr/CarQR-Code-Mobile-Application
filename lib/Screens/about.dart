import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_qr/Screens/app_info.dart';
import 'package:car_qr/Screens/terms_conditions.dart';
import 'package:car_qr/Screens/contact_us.dart';
import 'package:car_qr/Screens/faq.dart';

class About extends StatelessWidget {
  static const routeName = '/about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: new Text(
          'Help',
          style: TextStyle(fontSize: 22.0),
        ),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FAQ();
                          }));
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ContactUs();
                          }));
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
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TermsConditions();
                            }));
                          }),
                      _buildDivider(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AppInfo();
                            }));
                          },
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.infoCircle,
                              color: Colors.blue,
                            ),
                            title: Text("App Info"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ))
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
