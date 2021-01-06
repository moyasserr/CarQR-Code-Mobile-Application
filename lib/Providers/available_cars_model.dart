import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';
import 'package:http/http.dart' as http;

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

  addCar(Car car) {
    const url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/cars.json';
    return http
        .post(url,
            body: json.encode({
              'image': car.image,
              'carBrand': car.carBrand,
              'carModel': car.carModel,
              'cubicCentimeters': car.cubicCentimeters,
              'horsePower': car.horsePower,
              'maxSpeed': car.maxSpeed,
              'transmissonType': car.transmissonType,
              'seatsNumbers': car.seatsNumbers,
              'doorsType': car.doorsType,
              'roofType': car.roofType,
              'carPrice': car.carPrice,
              'manufactureCountry': car.manufactureCountry,
              'manufactureYear': car.manufactureYear,
              'mileAge': car.mileAge,
              'carHeight': car.carHeight,
              'carWidth': car.carWidth,
              'wheelBase': car.wheelBase,
              'truckBase': car.truckBase,
              'engineTorgue': car.engineTorgue,
              'engineAcceleration': car.engineAcceleration,
              'fuelTankCapacity': car.fuelTankCapacity,
              'fuelConsumption': car.fuelConsumption,
              'prefferedFuelType': car.prefferedFuelType,
              'brakeSafety': car.brakeSafety,
              'brake100To0': car.brake100To0,
              'rimDiameter': car.rimDiameter,
              'frontSuspension': car.frontSuspension,
              'backSuspension': car.backSuspension,
              'wheelWidth': car.wheelWidth,
              'color': car.color,
              'qrCode': car.qrCode,
            }))
        .then((res) {
      final newCar = Car(
        carBrand: car.carBrand,
        carModel: car.carModel,
        cubicCentimeters: car.cubicCentimeters,
        horsePower: car.horsePower,
        maxSpeed: car.maxSpeed,
        transmissonType: car.transmissonType,
        seatsNumbers: car.seatsNumbers,
        doorsType: car.doorsType,
        roofType: car.roofType,
        carPrice: car.carPrice,
        manufactureCountry: car.manufactureCountry,
        manufactureYear: car.manufactureYear,
        mileAge: car.mileAge,
        carHeight: car.carHeight,
        carWidth: car.carWidth,
        wheelBase: car.wheelBase,
        truckBase: car.truckBase,
        engineTorgue: car.engineTorgue,
        engineAcceleration: car.engineAcceleration,
        fuelTankCapacity: car.fuelTankCapacity,
        fuelConsumption: car.fuelConsumption,
        prefferedFuelType: car.prefferedFuelType,
        brakeSafety: car.brakeSafety,
        brake100To0: car.brake100To0,
        rimDiameter: car.rimDiameter,
        frontSuspension: car.frontSuspension,
        backSuspension: car.backSuspension,
        wheelWidth: car.wheelWidth,
        color: car.color,
        image: car.image,
        qrCode: car.qrCode,
      );
      _cars.add(newCar);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  void deleteCar(Car car) {
    _cars.remove(car);
    notifyListeners();
  }
}
