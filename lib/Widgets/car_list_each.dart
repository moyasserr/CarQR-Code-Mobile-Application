import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Providers/available_cars_model.dart';

class CarListEach extends StatelessWidget {
  final Car car;

  var modelProvider;

  CarListEach({@required this.car});

  @override
  Widget build(BuildContext context) {
    modelProvider = Provider.of<AvailableCarsModel>(context, listen: false);

    return Card(
      child: ListTile(
        leading: Image.asset(
          car.image,
          width: 100.0,
          height: 100.0,
        ),
        title: Text(car.carBrand),
        subtitle: Text(car.carModel),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
