import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/auth.dart';
import 'package:car_qr/Screens/carshowroomadmin.dart';
import 'package:flutter/material.dart';

class AppDrawerrrrr extends StatelessWidget {
  final User user;
  final AuthService _auth = AuthService();
  AppDrawerrrrr({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: Color.fromRGBO(32, 150, 243, 1)),
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            title: Text('Car Showroom'),
            automaticallyImplyLeading: false,
          ),
          user.userType == "2"
              ? ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Admin Pannel'),
                  onTap: () {
                    Navigator.pushNamed(context, Carshowroomadmin.routeName);
                  },
                )
              : Divider(height: 0.0),
          Divider(),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Showrooms'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('History'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
