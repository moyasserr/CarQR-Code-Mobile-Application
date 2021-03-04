import 'dart:convert';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/historyModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryProvider with ChangeNotifier {
  HistoryModel carsHistory;
  List<Car> cars = [];
  List<String> carKeys = [];

  int checkHistory(String carID){
    final carIndex = cars.indexWhere((car) => car.id == carID);
    return carIndex;
  }

  Future<void> carScannedHistory(Car car, String userID) async {
    final url ='https://carqr-e4c82-default-rtdb.firebaseio.com/users/$userID/history.json';
    int checkResult;

    try {
      var readCarF = readCarHistory(userID);
      if (readCarF == null) {
        await http.post(url,
            body: json.encode({
              'carID': car.id,
            }));
        return;
      }
      checkResult=checkHistory(car.id);
      if(checkResult==-1){
        await http.post(url,
            body: json.encode({
              'carID': car.id,
            }));
      }
      else
      {
        final url2 ='https://carqr-e4c82-default-rtdb.firebaseio.com/users/$userID/history/${carKeys[checkResult]}.json';
        final response = await http.delete(url2);
        if (response.statusCode >= 400) {
            print('Delete failed ${car.id}');
          } else {
            await http.post(url,
                body: json.encode({
                  'carID': car.id,
                }));
          }
      }

      cars.add(car);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> readCarHistory(String userID) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/users/$userID/history.json';

    try {
      final response = await http.get(url);
      final carData = json.decode(response.body) as Map<String, dynamic>;

      if (carData == null) {
        return null;
      }

      final List<Car> historyCars = [];
      final List<String> carKey = [];

      carData.forEach((key, data) async {
        historyCars.add(Car.emptyConst(id: data['carID']));
        carKey.add(key);
      });
      cars = historyCars;
      carKeys = carKey;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
