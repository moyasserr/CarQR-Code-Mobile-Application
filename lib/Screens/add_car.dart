import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Models/car.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final carDataController = TextEditingController();

  void dispose() {
    carDataController.dispose();
    super.dispose();
  }

  void onAdd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: ListView(
        children: <Widget>[
          TextFormField(
            controller: carDataController,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('ADD'),
          )
        ],
      ),
    );
  }
}
