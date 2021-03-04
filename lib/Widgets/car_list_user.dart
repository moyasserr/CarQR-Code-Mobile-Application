import 'package:car_qr/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Widgets/car_list_each_user.dart';

class CarListUser extends StatelessWidget {
  final List<Car> cars;
  final User loggedUser;

  CarListUser({@required this.cars, @required this.loggedUser});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChilderenCars(),
    );
  }

  List<Widget> getChilderenCars() {
    return cars
        .map((care) => CarListEachUser(
              car: care,
              loggedUser: loggedUser,
            ))
        .toList();
  }
}
