import 'package:flutter/material.dart';
import 'package:car_qr/Widgets/car_list.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/App_Admin/add_car.dart';

class AdminCarsPanal extends StatefulWidget {
  static const routeName = '/adminapp';
  @override
  _AdminCarsPanalState createState() => _AdminCarsPanalState();
}

class _AdminCarsPanalState extends State<AdminCarsPanal> {
  var _isLoading = true;

  @override
  void initState() {
    Provider.of<AvailableCarsModel>(context, listen: false)
        .readCars()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCar()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Consumer<AvailableCarsModel>(
                builder: (context, cars, child) => CarList(
                  cars: cars.allCars,
                ),
              ),
            ),
    );
  }
}
