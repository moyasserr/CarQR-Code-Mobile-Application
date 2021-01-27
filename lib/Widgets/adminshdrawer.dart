import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
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
            leading: Icon(Icons.shop),
            title: Text('My Showrooms'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/');
              Navigator.pushNamed(context, "/adminshowrooms");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('My Car List'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
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
