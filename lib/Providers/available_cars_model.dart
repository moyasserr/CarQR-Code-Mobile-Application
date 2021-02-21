import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';
import 'package:http/http.dart' as http;

class AvailableCarsModel with ChangeNotifier {
  List<Car> _cars = [];

  AvailableCarsModel() {}

  UnmodifiableListView<Car> get allCars => UnmodifiableListView(_cars);

  Future<Car> findById(String id) async {
    if (_cars.isEmpty) {
      await readCars();
    }
    return _cars.firstWhere((car) => car.id == id);
  }

  Future<void> readCars() async {
    const url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/cars.json';
    try {
      print("success");
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<Car> dbCars = [];
      dbData.forEach((key, data) {
        dbCars.add(Car(
          id: key,
          carBrand: data['carBrand'],
          carModel: data['carModel'],
          cubicCentimeters: data['cubicCentimeters'],
          horsePower: data['horsePower'],
          maxSpeed: data['maxSpeed'],
          transmissonType: data['transmissonType'],
          seatsNumbers: data['seatsNumbers'],
          doorsType: data['doorsType'],
          roofType: data['roofType'],
          manufactureCountry: data['manufactureCountry'],
          manufactureYear: data['manufactureYear'],
          mileAge: data['mileAge'],
          carHeight: data['carHeight'],
          carWidth: data['carWidth'],
          wheelBase: data['wheelBase'],
          truckBase: data['truckBase'],
          engineTorgue: data['engineTorgue'],
          engineAcceleration: data['engineAcceleration'],
          fuelTankCapacity: data['fuelTankCapacity'],
          fuelConsumption: data['fuelConsumption'],
          prefferedFuelType: data['prefferedFuelType'],
          brakeSafety: data['brakeSafety'],
          brake100To0: data['brake100To0'],
          rimDiameter: data['rimDiameter'],
          frontSuspension: data['frontSuspension'],
          backSuspension: data['backSuspension'],
          wheelWidth: data['wheelWidth'],
          color: data['color'],
          image: data['image'],
          qrCode: data['qrCode'],
        ));
      });
      _cars = dbCars;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

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
        id: jsonDecode(res.body)['name'],
        carBrand: car.carBrand,
        carModel: car.carModel,
        cubicCentimeters: car.cubicCentimeters,
        horsePower: car.horsePower,
        maxSpeed: car.maxSpeed,
        transmissonType: car.transmissonType,
        seatsNumbers: car.seatsNumbers,
        doorsType: car.doorsType,
        roofType: car.roofType,
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

  Future<void> updateCar(String id, Car newCar) async {
    final url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$id.json';

    final carIndex = _cars.indexWhere((car) => car.id == id);
    if (carIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'image': newCar.image,
            'carBrand': newCar.carBrand,
            'carModel': newCar.carModel,
            'cubicCentimeters': newCar.cubicCentimeters,
            'horsePower': newCar.horsePower,
            'maxSpeed': newCar.maxSpeed,
            'transmissonType': newCar.transmissonType,
            'seatsNumbers': newCar.seatsNumbers,
            'doorsType': newCar.doorsType,
            'roofType': newCar.roofType,
            'manufactureCountry': newCar.manufactureCountry,
            'manufactureYear': newCar.manufactureYear,
            'mileAge': newCar.mileAge,
            'carHeight': newCar.carHeight,
            'carWidth': newCar.carWidth,
            'wheelBase': newCar.wheelBase,
            'truckBase': newCar.truckBase,
            'engineTorgue': newCar.engineTorgue,
            'engineAcceleration': newCar.engineAcceleration,
            'fuelTankCapacity': newCar.fuelTankCapacity,
            'fuelConsumption': newCar.fuelConsumption,
            'prefferedFuelType': newCar.prefferedFuelType,
            'brakeSafety': newCar.brakeSafety,
            'brake100To0': newCar.brake100To0,
            'rimDiameter': newCar.rimDiameter,
            'frontSuspension': newCar.frontSuspension,
            'backSuspension': newCar.backSuspension,
            'wheelWidth': newCar.wheelWidth,
            'color': newCar.color,
            'qrCode': newCar.qrCode,
          }));
      _cars[carIndex] = newCar;
      notifyListeners();
    }
  }

  void deleteCar(String id) {
    final url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$id.json';
    final existingInd = _cars.indexWhere((element) => element.id == id);
    var existing = _cars[existingInd];
    _cars.removeAt(existingInd);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        _cars.insert(existingInd, existing);
        notifyListeners();
        print(res.statusCode);
        throw Exception('Delete Failid for id is $id');
      }
    });
    notifyListeners();
  }
}
