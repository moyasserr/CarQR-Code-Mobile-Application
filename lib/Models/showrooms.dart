import 'dart:convert';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/admin_showrooms.dart';
import 'package:provider/provider.dart';

import '../Models/HTTPException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/showroom.dart';

class CarShowrooms with ChangeNotifier {
  final User user;

  List<CarShowRoom> _showrooms = [];

  CarShowRoom _showroom;

  CarShowrooms({@required this.user});
  List<CarShowRoom> get showrooms {
    return [..._showrooms];
  }

  CarShowRoom get showroom {
    return _showroom;
  }

  // CarShowRoom findById(String id) {
  //   return _showrooms.firstWhere((showroom) => showroom.id == id);
  // }

  CarShowRoom findById(String id) {
    return _showroom;
  }

  Future<CarShowRoom> fetchAdminShowroom() async {
    var url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms.json?auth=${user.token}';
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return null;
      }
      CarShowRoom dbShowroom;
      dbData.forEach((key, data) {
        if (data['adminId'] == user.uid) {
          dbShowroom = new CarShowRoom(
            id: key,
            showRoomName: data['showroomName'],
            phoneNumber: data['phoneNumber'],
            location: data['location'],
            image: data['image'],
          );
          _showroom = dbShowroom;
          AdminShowroomsScreen.isloading = true;
          notifyListeners();
          AdminShowroomsScreen.test = dbShowroom;
          return dbShowroom;
        }
      });
      //_showrooms = dbShowroom;
      notifyListeners();
      return null;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addShowroom(CarShowRoom showroom) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms.json?auth=${user.token}';

    try {
      final response = await http.post(url,
          body: json.encode({
            'showroomName': showroom.showRoomName,
            'phoneNumber': showroom.phoneNumber,
            'location': showroom.location,
            'image': showroom.image,
            'adminId': user.uid,
          }));

      final newShowroom = CarShowRoom(
          showRoomName: showroom.showRoomName,
          phoneNumber: showroom.phoneNumber,
          location: showroom.location,
          image: showroom.image,
          id: json.decode(response.body)['name']);
      _showroom = newShowroom;
      AdminShowroomsScreen.isloading = true;
      //_showrooms.add(newShowroom);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addcarToShowroom(String id, Car car, String price) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id/cars.json?auth=${user.token}';

    try {
      await http.post(url,
          body: json.encode({
            'carID': car.id,
            // 'carBrand': car.carBrand,
            // 'carModel': car.carModel,
            // 'carImage': car.image,
            'carPrice': price,
          }));

      _showroom.stockCars.add(car);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchShowroomCars(String id) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id/cars.json?auth=${user.token}';

    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return null;
      }
      final List<Car> shCars = [];
      dbData.forEach((key, data) {
        shCars.add(Car.emptyConst(
            id: data['carID'],
            // carBrand: data['carBrand'],
            // carModel: data['carModel'],
            // image: data['carImage'],
            price: data['carPrice']));

        _showroom.stockCars = shCars;
        notifyListeners();
        return _showroom;
      });
      notifyListeners();
      return null;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> updateShowroom(String id, CarShowRoom newShowroom) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json?auth=${user.token}';
    try {
      await http.patch(url,
          body: json.encode({
            'showroomName': newShowroom.showRoomName,
            'phoneNumber': newShowroom.phoneNumber,
            'location': newShowroom.location,
            'image': newShowroom.image,
          }));
      _showroom = newShowroom;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteShowroom(String id) async {
    print("showroom id 45 :$id");
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json?auth=${user.token}';
    var exisitingShowroom = _showroom;
    _showroom = null;
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      print("stststs : ${response.statusCode}");
      _showroom = exisitingShowroom;
      notifyListeners();
      throw HTTPException('Delete failed for showroom whose id is $id');
    }
    exisitingShowroom = null;
  }
}
