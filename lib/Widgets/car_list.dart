import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Widgets/car_list_each.dart';

class CarList extends StatelessWidget {
  final List<Car> cars;

  CarList({@required this.cars});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChilderenCars(),
    );
  }

  List<Widget> getChilderenCars() {
    return cars.map((care) => CarListEach(car: care)).toList();
  }
}
