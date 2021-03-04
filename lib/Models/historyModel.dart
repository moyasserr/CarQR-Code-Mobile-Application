import 'dart:convert';
import 'package:car_qr/Models/car.dart';
import 'package:http/http.dart' as http;


class HistoryModel {


  List <Car> cars=[];

  HistoryModel({
    this.cars,
  }){this.cars=[]; print(this.cars.length);}

  
}