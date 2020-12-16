import 'package:flutter/cupertino.dart';

class Car {
  String carBrand;
  String carModel;
  int cubicCentimeters;
  int horsePower;
  double maxSpeed;
  String transmissonType;
  int seatsNumbers;
  String doorsType;
  String roofType;
  double carPrice;
  String manufactureCountry;
  int manufactureYear;
  int mileAge;
  double carHeight;
  double carWidth;
  double wheelBase;
  double truckBase;
  double engineTorgue;
  double engineAcceleration;
  double fuelTankCapacity;
  double fuelConsumption;
  String prefferedFuelType;
  String brakeSafety;
  double brake100To0;
  double rimDiameter;
  String frontSuspension;
  String backSuspension;
  double wheelWidth;
  String color;
  String image;
  String qrCode;

  Car({
    @required this.carBrand,
    @required this.carModel,
    @required this.cubicCentimeters,
    @required this.horsePower,
    this.maxSpeed = 0,
    this.transmissonType = 'N/A',
    this.seatsNumbers = 0,
    this.doorsType = 'N/A',
    this.roofType = 'N/A',
    this.carPrice = 0,
    this.manufactureCountry = 'N/A',
    this.manufactureYear = 0,
    this.mileAge = 0,
    this.carHeight = 0,
    this.carWidth = 0,
    this.wheelBase = 0,
    this.truckBase = 0,
    this.engineTorgue = 0,
    this.engineAcceleration = 0,
    this.fuelConsumption = 0,
    this.fuelTankCapacity = 0,
    this.prefferedFuelType = 'N/A',
    this.brakeSafety = 'N/A',
    this.brake100To0 = 0,
    this.rimDiameter = 0,
    this.frontSuspension,
    this.backSuspension = 'N/A',
    this.wheelWidth = 0,
    this.color = 'N/A',
    @required this.image,
    this.qrCode,
  });

  Map<String, dynamic> get map {
    return {
      "carBrand": carBrand,
      "carModel": carModel,
      "cubicCentimeters": cubicCentimeters,
      "horsePower": horsePower,
      "maxSpeed": maxSpeed,
      "transmissonType": transmissonType,
      "seatsNumbers": seatsNumbers,
      "doorsType": doorsType,
      "roofType": roofType,
      "carPrice": carPrice,
      "manufactureCountry": manufactureCountry,
      "manufactureYear": manufactureYear,
      "mileAge": mileAge,
      "carHeight": carHeight,
      "carWidth": carWidth,
      "wheelBase": wheelBase,
      "truckBase": truckBase,
      "engineTorgue": engineTorgue,
      "engineAcceleration": engineAcceleration,
      "fuelConsumption": fuelConsumption,
      "fuelTankCapacity": fuelTankCapacity,
      "prefferedFuelType": prefferedFuelType,
      "brakeSafety": brakeSafety,
      "brake100To0": brake100To0,
      "rimDiameter": rimDiameter,
      "frontSuspension": frontSuspension,
      "backSuspension": backSuspension,
      "wheelWidth": wheelWidth,
      "color": color,
      "image": image,
      "qrCode": qrCode,
    };
  }
}
