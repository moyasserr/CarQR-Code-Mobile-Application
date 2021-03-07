import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/auth.dart';
import 'package:car_qr/Screens/about.dart';
import 'package:car_qr/Screens/admin_cars_screen.dart';
import 'package:car_qr/Screens/car_list_user.dart';
import 'package:car_qr/Screens/carshowroomadmin.dart';
import 'package:car_qr/Screens/history.dart';
import 'package:car_qr/Screens/settings.dart';
import 'package:car_qr/Screens/user_showrooms.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  final AuthService _auth = AuthService();
  AppDrawer({@required this.user});

  @override
  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/images/logo.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              //bottom: 1.0,
              //  left: 16.0,
              child: UserAccountsDrawerHeader(
            accountName: Text("${user.firstName} ${user.lastName}"),
            accountEmail: Text("${user.eMail}"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/logo.jpg'))),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "${user.firstName[0]}".toUpperCase(),
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          )),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _createHeader(context),
          user.userType == "2"
              ? ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Admin Pannel'),
                  onTap: () {
                    Navigator.pushNamed(context, Carshowroomadmin.routeName);
                  },
                )
              : user.userType == "0"
                  ? ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      title: Text('Admin Pannel'),
                      onTap: () {
                        Navigator.pushNamed(context, AdminCarsPanal.routeName);
                      },
                    )
                  : Divider(height: 0.0),
          Divider(),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Showrooms'),
            onTap: () {
              Navigator.pushNamed(context, UserShowrooms.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Cars'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CarlistUser(
                          loggedUser: user,
                        )),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('History'),
            onTap: () {
              Navigator.pushNamed(context, History.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Settings.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pushNamed(context, About.routeName);
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
          //SizedBox(height: MediaQuery.of(context).size.height-20),
          ListTile(
            title: Text('1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
