import 'dart:collection';
import 'dart:convert';
import 'package:car_qr/Models/review.dart';
import 'package:car_qr/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/car.dart';
import 'package:http/http.dart' as http;

class AvailableCarsModel with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> _carsClone = [];
  final User user;

  AvailableCarsModel({@required this.user});

  UnmodifiableListView<Car> get allCars => UnmodifiableListView(_cars);

  Future<Car> findById(String id) async {
    if (_cars.isEmpty) {
      await readCars();
    }
    return _cars.firstWhere((car) => car.id == id);
  }

  void searchCars(String keyword) {
    List<Car> tempCars = [];

    if (keyword == "") {
      _cars = _carsClone;
    } else {
      for (int i = 0; i < _cars.length; i++) {
        if (_cars[i].carBrand.toLowerCase().contains((keyword.toLowerCase()))) {
          tempCars.add(_cars[i]);
        }
      }
      _cars = tempCars;
    }

    notifyListeners();
  }

  Future<void> readCars() async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars.json?auth=${user.token}';
    try {
      print("success");
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<Car> dbCars = [];
      dbData.forEach((key, data) async {
        dbCars.add(Car(
          id: key,
          carBrand: data['carBrand'],
          carModel: data['carModel'],
          cubicCentimeters: data['cubicCentimeters'],
          horsePower: data['horsePower'],
          maxSpeed: data['maxSpeed'],
          transmissonType: data['transmissonType'],
          seatsNumbers: data['seatsNumbers'],
          doorsType: data['doorsType'],
          roofType: data['roofType'],
          manufactureCountry: data['manufactureCountry'],
          manufactureYear: data['manufactureYear'],
          mileAge: data['mileAge'],
          carHeight: data['carHeight'],
          carWidth: data['carWidth'],
          wheelBase: data['wheelBase'],
          truckBase: data['truckBase'],
          engineTorgue: data['engineTorgue'],
          engineAcceleration: data['engineAcceleration'],
          fuelTankCapacity: data['fuelTankCapacity'],
          fuelConsumption: data['fuelConsumption'],
          prefferedFuelType: data['prefferedFuelType'],
          brakeSafety: data['brakeSafety'],
          brake100To0: data['brake100To0'],
          rimDiameter: data['rimDiameter'],
          frontSuspension: data['frontSuspension'],
          backSuspension: data['backSuspension'],
          wheelWidth: data['wheelWidth'],
          color: data['color'],
          image: data['image'],
          qrCode: data['qrCode'],
        ));
        this.fetchCarReviews(key, dbCars);
      });
      _cars = dbCars;
      _carsClone = _cars;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  addCar(Car car) {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars.json?auth=${user.token}';
    return http
        .post(url,
            body: json.encode({
              'image': car.image,
              'carBrand': car.carBrand,
              'carModel': car.carModel,
              'cubicCentimeters': car.cubicCentimeters,
              'horsePower': car.horsePower,
              'maxSpeed': car.maxSpeed,
              'transmissonType': car.transmissonType,
              'seatsNumbers': car.seatsNumbers,
              'doorsType': car.doorsType,
              'roofType': car.roofType,
              'manufactureCountry': car.manufactureCountry,
              'manufactureYear': car.manufactureYear,
              'mileAge': car.mileAge,
              'carHeight': car.carHeight,
              'carWidth': car.carWidth,
              'wheelBase': car.wheelBase,
              'truckBase': car.truckBase,
              'engineTorgue': car.engineTorgue,
              'engineAcceleration': car.engineAcceleration,
              'fuelTankCapacity': car.fuelTankCapacity,
              'fuelConsumption': car.fuelConsumption,
              'prefferedFuelType': car.prefferedFuelType,
              'brakeSafety': car.brakeSafety,
              'brake100To0': car.brake100To0,
              'rimDiameter': car.rimDiameter,
              'frontSuspension': car.frontSuspension,
              'backSuspension': car.backSuspension,
              'wheelWidth': car.wheelWidth,
              'color': car.color,
              'qrCode': car.qrCode,
            }))
        .then((res) {
      final newCar = Car(
        id: jsonDecode(res.body)['name'],
        carBrand: car.carBrand,
        carModel: car.carModel,
        cubicCentimeters: car.cubicCentimeters,
        horsePower: car.horsePower,
        maxSpeed: car.maxSpeed,
        transmissonType: car.transmissonType,
        seatsNumbers: car.seatsNumbers,
        doorsType: car.doorsType,
        roofType: car.roofType,
        manufactureCountry: car.manufactureCountry,
        manufactureYear: car.manufactureYear,
        mileAge: car.mileAge,
        carHeight: car.carHeight,
        carWidth: car.carWidth,
        wheelBase: car.wheelBase,
        truckBase: car.truckBase,
        engineTorgue: car.engineTorgue,
        engineAcceleration: car.engineAcceleration,
        fuelTankCapacity: car.fuelTankCapacity,
        fuelConsumption: car.fuelConsumption,
        prefferedFuelType: car.prefferedFuelType,
        brakeSafety: car.brakeSafety,
        brake100To0: car.brake100To0,
        rimDiameter: car.rimDiameter,
        frontSuspension: car.frontSuspension,
        backSuspension: car.backSuspension,
        wheelWidth: car.wheelWidth,
        color: car.color,
        image: car.image,
        qrCode: car.qrCode,
      );
      _cars.add(newCar);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> updateCar(String id, Car newCar) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$id.json?auth=${user.token}';

    final carIndex = _cars.indexWhere((car) => car.id == id);
    if (carIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'image': newCar.image,
            'carBrand': newCar.carBrand,
            'carModel': newCar.carModel,
            'cubicCentimeters': newCar.cubicCentimeters,
            'horsePower': newCar.horsePower,
            'maxSpeed': newCar.maxSpeed,
            'transmissonType': newCar.transmissonType,
            'seatsNumbers': newCar.seatsNumbers,
            'doorsType': newCar.doorsType,
            'roofType': newCar.roofType,
            'manufactureCountry': newCar.manufactureCountry,
            'manufactureYear': newCar.manufactureYear,
            'mileAge': newCar.mileAge,
            'carHeight': newCar.carHeight,
            'carWidth': newCar.carWidth,
            'wheelBase': newCar.wheelBase,
            'truckBase': newCar.truckBase,
            'engineTorgue': newCar.engineTorgue,
            'engineAcceleration': newCar.engineAcceleration,
            'fuelTankCapacity': newCar.fuelTankCapacity,
            'fuelConsumption': newCar.fuelConsumption,
            'prefferedFuelType': newCar.prefferedFuelType,
            'brakeSafety': newCar.brakeSafety,
            'brake100To0': newCar.brake100To0,
            'rimDiameter': newCar.rimDiameter,
            'frontSuspension': newCar.frontSuspension,
            'backSuspension': newCar.backSuspension,
            'wheelWidth': newCar.wheelWidth,
            'color': newCar.color,
            'qrCode': newCar.qrCode,
          }));
      _cars[carIndex] = newCar;
      notifyListeners();
    }
  }

  void deleteCar(String id) {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$id.json?auth=${user.token}';
    final existingInd = _cars.indexWhere((element) => element.id == id);
    var existing = _cars[existingInd];
    _cars.removeAt(existingInd);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        _cars.insert(existingInd, existing);
        notifyListeners();
        print(res.statusCode);
        throw Exception('Delete Failid for id is $id');
      }
    });
    notifyListeners();
  }

  Future<void> fetchCarReviews(String carID, List<Car> cars) async {
    print(carID);
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$carID/reviews.json?auth=${user.token}';
    final carIndex = cars.indexWhere((car) => car.id == carID);
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      print(dbData);
      final List<Review> carReviews = [];
      try {
        dbData.forEach((key, data) {
          carReviews.add(
            Review(
              id: key,
              userID: data['userID'],
              rating: data['rating'],
              comment: data['comment'],
            ),
          );
        });
        _cars[carIndex].reviews = carReviews;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  void addReview(
      String userID, String comment, double rating, String carID) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$carID/reviews.json?auth=${user.token}';
    final carIndex = _cars.indexWhere((car) => car.id == carID);
    try {
      await http
          .post(url,
              body: json.encode({
                'userID': userID,
                'rating': rating,
                'comment': comment,
              }))
          .then((value) {
        final newReview = Review(
          id: jsonDecode(value.body)['name'],
          userID: userID,
          rating: rating,
          comment: comment,
        );
        _cars[carIndex].reviews.add(newReview);
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> editReview({String id, String carID, Review newReview}) async {
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$carID/reviews/$id.json?auth=${user.token}';
    final carIndex = _cars.indexWhere((car) => car.id == carID);

    if (carIndex >= 0) {
      final reviewIndex =
          _cars[carIndex].reviews.indexWhere((review) => review.id == id);
      await http
          .patch(url,
              body: json.encode({
                'rating': newReview.rating,
                'comment': newReview.comment,
              }))
          .then((value) {
        _cars[carIndex].reviews[reviewIndex] = newReview;
        notifyListeners();
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void deleteReview(String carID, String id) {
    print(user.token);
    final url =
        'https://carqr-e4c82-default-rtdb.firebaseio.com/cars/$carID/reviews/$id.json?auth=${user.token}';
    final carInd = _cars.indexWhere((element) => element.id == carID);
    final reviewInd =
        _cars[carInd].reviews.indexWhere((element) => element.id == id);
    var reviewTemp = _cars[carInd].reviews[reviewInd];
    _cars[carInd].reviews.removeAt(reviewInd);
    http.delete(url).then((res) {
      if (res.statusCode >= 400) {
        _cars[carInd].reviews.insert(reviewInd, reviewTemp);
        notifyListeners();
        print(res.statusCode);
        throw Exception('Delete Failid for id is $id');
      }
    });
    notifyListeners();
  }
}
