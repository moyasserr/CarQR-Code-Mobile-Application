import 'dart:convert';
import '../Models/HTTPException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/showroom.dart';

class CarShowrooms with ChangeNotifier {
  List<CarShowRoom> _showrooms = [];

  List<CarShowRoom> get showrooms {
    return [..._showrooms];
  }

  CarShowRoom findById(String id) {
    return _showrooms.firstWhere((showroom) => showroom.id == id);
  }

  Future<void> fetchShowrooms() async {
    const url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms.json';
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<CarShowRoom> dbShowrooms = [];
      dbData.forEach((key, data) {
        dbShowrooms.add(CarShowRoom(
          id: key,
          showRoomName: data['showroomName'],
          phoneNumber: data['phoneNumber'],
          location: data['location'],
          image: data['image'],
        ));
      });
      _showrooms = dbShowrooms;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

//'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'
  Future<void> addShowroom(CarShowRoom showroom) async {
    const url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms.json';

    return http
        .post(url,
            body: json.encode({
              'showroomName': showroom.showRoomName,
              'phoneNumber': showroom.phoneNumber,
              'location': showroom.location,
              'image': showroom.image,
            }))
        .then((res) {
      final newShowroom = CarShowRoom(
          showRoomName: showroom.showRoomName,
          phoneNumber: showroom.phoneNumber,
          location: showroom.location,
          image: showroom.image,
          id: jsonDecode(res.body)['name']);
      _showrooms.add(newShowroom);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> updateShowroom(String id, CarShowRoom newShowroom) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json';

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
    }
  }

  void deleteShowroom(String id) {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/showrooms/$id.json';
    final existingshowrrom =
        _showrooms.indexWhere((showroom) => showroom.id == id);
    var existing = _showrooms[existingshowrrom];
    _showrooms.removeAt(existingshowrrom);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        _showrooms.insert(existingshowrrom, existing);
        notifyListeners();
        print(res.statusCode);
        throw HTTPException('Delete failed for showroom whose id is $id');
      }
    });
    notifyListeners();
  }
}
