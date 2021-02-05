import 'package:flutter/cupertino.dart';

import 'car.dart';

class CarShowRoom with ChangeNotifier {
  String id;
  String showRoomName;
  String phoneNumber;
  String location;
  String image;

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
