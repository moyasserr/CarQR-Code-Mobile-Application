import 'car.dart';

class CarShowRoom {
  String showRoomName;
  String phoneNumber;
  String location;

  List<Car> stockCars;

  CarShowRoom(
      {this.showRoomName, this.phoneNumber, this.location, this.stockCars});

  Map<String, dynamic> get map {
    return {
      "showRoomName": showRoomName,
      "phoneNumber": phoneNumber,
      "location": location,
      "stockCars": stockCars,
    };
  }
}
