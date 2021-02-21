import 'package:car_qr/Screens/ad_sh_carlist.dart';
import 'package:car_qr/Screens/admin_showrooms.dart';
import 'package:car_qr/Screens/carshowroomadmin.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: Icon(Icons.person),
            title: Text('Admin'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page'),
            onTap: () {
              Navigator.pushNamed(context, Carshowroomadmin.routeName);
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
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
