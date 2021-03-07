import 'package:car_qr/Models/car.dart';

class CarShowRoom {
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
      this.stockCars}) {
    this.stockCars = [];
  }
}
