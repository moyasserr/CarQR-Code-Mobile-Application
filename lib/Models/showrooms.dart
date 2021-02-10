import 'dart:convert';
import 'package:car_qr/Models/user.dart';

import '../Models/HTTPException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/showroom.dart';

class CarShowrooms with ChangeNotifier {
  final User user;

  List<CarShowRoom> _showrooms = [];

  CarShowrooms({@required this.user});
  List<CarShowRoom> get showrooms {
    return [..._showrooms];
  }

  CarShowRoom findById(String id) {
    return _showrooms.firstWhere((showroom) => showroom.id == id);
  }

  Future<void> fetchShowrooms() async {
    var url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms.json?auth=${user.token}';
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return;
      }
      final List<CarShowRoom> dbShowrooms = [];
      dbData.forEach((key, data) {
        if (data['adminId'] == user.uid) {
          dbShowrooms.add(CarShowRoom(
            id: key,
            showRoomName: data['showroomName'],
            phoneNumber: data['phoneNumber'],
            location: data['location'],
            image: data['image'],
          ));
        }
      });
      _showrooms = dbShowrooms;
      notifyListeners();
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
      _showrooms.add(newShowroom);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateShowroom(String id, CarShowRoom newShowroom) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json?auth=${user.token}';

    final showIndex = _showrooms.indexWhere((showroom) => showroom.id == id);
    if (showIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'showroomName': newShowroom.showRoomName,
            'phoneNumber': newShowroom.phoneNumber,
            'location': newShowroom.location,
            'image': newShowroom.image,
          }));
      _showrooms[showIndex] = newShowroom;
      notifyListeners();
    } else {
      print("Error updating showroom");
    }
  }

  void deleteShowroom(String id) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json?auth=${user.token}';
    final existingshowrrom =
        _showrooms.indexWhere((showroom) => showroom.id == id);
    var existing = _showrooms[existingshowrrom];
    _showrooms.removeAt(existingshowrrom);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _showrooms.insert(existingshowrrom, existing);
      notifyListeners();
      throw HTTPException('Delete failed for showroom whose id is $id');
    }
    existingshowrrom == null;
  }
}
