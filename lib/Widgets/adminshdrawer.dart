import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/auth.dart';
import 'package:car_qr/Screens/ad_sh_carlist.dart';
import 'package:car_qr/Screens/admin_showrooms.dart';
import 'package:car_qr/Screens/carshowroomadmin.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  final User user;
  final AuthService _auth = AuthService();
  AdminDrawer({@required this.user});

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
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Admin Page'),
            onTap: () {
              Navigator.pushNamed(context, Carshowroomadmin.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('App Home Page'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('My Showroom'),
            onTap: () {
              Navigator.pushNamed(context, AdminShowroomsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('My Car List'),
            onTap: () {
              Navigator.pushNamed(context, AdShCarList.routeName);
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
