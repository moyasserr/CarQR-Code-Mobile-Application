import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/showrooms.dart';

class Carshowroomadmin extends StatefulWidget {
  static const routeName = '/showroom-admin';
  final User user;
  Carshowroomadmin({@required this.user});

  @override
  _CarshowroomadminState createState() => _CarshowroomadminState();
}

class _CarshowroomadminState extends State<Carshowroomadmin> {
  // bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Manage Your Showrooms"),
      ),
      drawer: AdminDrawer(user: widget.user),
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10, 180, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("Check Out The Latest Cars ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 240, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("In The System : ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 80),
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/carlist");
                },
                color: Colors.redAccent[400],
                textColor: Colors.white,
                child: Text("Cars List", style: TextStyle(fontSize: 23)),
                padding: EdgeInsets.all(30),
                //shape: CircleBorder(),
              )),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50.0),
              child: RichText(
                text: TextSpan(
                  text: "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 40),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Admin',
                        style: TextStyle(color: Colors.redAccent[400])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
