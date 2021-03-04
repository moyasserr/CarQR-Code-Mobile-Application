import 'package:flutter/material.dart';
import 'package:car_qr/main.dart';
import 'package:car_qr/Screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Nav(
        user: user,
      );
    }
  }
}
