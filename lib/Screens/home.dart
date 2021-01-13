import 'package:flutter/material.dart';
import 'package:car_qr/main.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/about.dart';
import 'package:car_qr/Screens/carshowroom.dart';
import 'package:car_qr/Screens/history.dart';
import 'package:car_qr/Screens/signin.dart';
import 'package:car_qr/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AvailableCarsModel(),
      child: MaterialApp(
        routes: {
          '/': (context) => MyApp(),
          '/history': (context) => History(),
          '/signin': (context) => Signin(),
          '/showrooms': (context) => Carshowroom(),
          '/settings': (context) => Settings(),
          //'/car_description': (context) => CarDetails(),
          '/about': (context) => About(),
        },
      ),
    );
  }
}