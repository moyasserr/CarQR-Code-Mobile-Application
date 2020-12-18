import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';

class AvailableCarsModel extends ChangeNotifier {
  final List<Car> _cars = [
    Car(
        carBrand: 'Porshe',
        carModel: 'S',
        cubicCentimeters: 2000,
        horsePower: 500,
        image: 'assets/images/porsche.png'),
    Car(
        carBrand: 'Lambo',
        carModel: 'K',
        cubicCentimeters: 2500,
        horsePower: 600,
        image: 'assets/images/instaicon.png'),
    Car(
        carBrand: 'Porshe',
        carModel: 'S',
        cubicCentimeters: 2000,
        horsePower: 500,
        image: 'assets/images/porsche.png'),
  ];

  UnmodifiableListView<Car> get allCars => UnmodifiableListView(_cars);

  void addCar(Car car) {
    _cars.add(car);
    notifyListeners();
  }

  void deleteCar(Car car) {
    _cars.remove(car);
    notifyListeners();
  }
}
