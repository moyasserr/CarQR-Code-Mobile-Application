import 'package:flutter/cupertino.dart';

import 'car.dart';

class CarShowRoom with ChangeNotifier {
  final String id;
  final String showRoomName;
  final String phoneNumber;
  final String location;
  final String image;

  List<Car> stockCars;

  CarShowRoom(
      {this.id,
      this.showRoomName,
      this.phoneNumber,
      this.location,
      this.image,
      this.stockCars});

  // Map<String, dynamic> get map {
  //   return {
  //     "showRoomName": showRoomName,
  //     "phoneNumber": phoneNumber,
  //     "location": location,
  //     "stockCars": stockCars,
  //   };
  // }
}
