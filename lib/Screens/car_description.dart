import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'carreviews.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Models/car.dart';

class CarDetails extends StatefulWidget {
  final String carId;

  CarDetails({@required this.carId});
  @override
  _CarDetailsState createState() => _CarDetailsState(carId: this.carId);
}

class _CarDetailsState extends State<CarDetails> with TickerProviderStateMixin {
  bool isLoading = true;
  bool checkPrice = false;
  AnimationController controller;
  Animation<double> animation;
  final String carId;
  Car car;
  String carprice;
  _CarDetailsState({@required this.carId});

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  getCar(BuildContext context) async {
    carprice = ModalRoute.of(context).settings.arguments as String;
    if (carprice == null) {
      checkPrice = true;
    }
    car = await Provider.of<AvailableCarsModel>(context, listen: false)
        .findById(carId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCar(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Car Description'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(padding: const EdgeInsets.all(8), children: <Widget>[
              Center(
                child: FadeTransition(
                  opacity: animation,
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        car.image,
                        width: 230.0,
                        height: 150.0,
                      ),
                      Container(
                          width: 300.0,
                          height: 170.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xff2c2c2c),
                          ),
                          child: Column(children: <Widget>[
                            Text(
                              car.carBrand,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              //'911 Carrera'
                              car.carModel,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BuildButtonColumn(
                                      Colors.white,
                                      Icons.time_to_leave,
                                      '${car.cubicCentimeters} CC'),
                                  BuildButtonColumn(Colors.white, Icons.toys,
                                      '${car.horsePower} HP'),
                                  BuildButtonColumn(Colors.white,
                                      Icons.auto_fix_high, car.transmissonType),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BuildButtonColumn(Colors.white, Icons.speed,
                                      '${car.maxSpeed} KM/H'),
                                  BuildButtonColumn(Colors.white,
                                      Icons.list_alt, '${car.doorsType}'),
                                  BuildButtonColumn(
                                      Colors.white,
                                      Icons.airline_seat_flat,
                                      '${car.seatsNumbers}'),
                                ]),
                          ])),
                      Divider(color: Colors.black),
                      Text(
                        'Main Information',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      checkPrice
                          ? Divider(height: 0.0)
                          : Text(
                              'Price: $carprice\$'.replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 18,
                                color: Colors.black,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.left,
                            ),
                      Text(
                        'Year of manufacture: ${car.manufactureYear}',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Country of manufacture: ${car.manufactureCountry}',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Milleage: 0 KM',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Text(
                        'Dimensions',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Height: ${car.carHeight} M',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Length: 2.5 M',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Width: ${car.carWidth} M',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Wheel Base: ${car.wheelBase} M',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Trunk Space: ${car.truckBase} L',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Text(
                        'Engine',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Torque: ${car.engineTorgue} NM',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Acceleration: ${car.engineAcceleration} Seconds ',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Maximum Speed: ${car.maxSpeed} KM/h',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Text(
                        'Fuel',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Fuel Tank: ${car.fuelTankCapacity} L',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Fuel Consumption: ${car.fuelConsumption} L in 100 KM',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Fuel Type: ${car.prefferedFuelType} 95',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Text(
                        'Brakes',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Brake Duration from 100 to 0: ${car.brake100To0} Seconds',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Brake Safety: ${car.brakeSafety}',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Text(
                        'Wheel Details',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Width: ${car.wheelWidth} Inch',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Rim Diameter; ${car.rimDiameter} Inch',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Front Suspension: ${car.frontSuspension}',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Back Suspension: ${car.backSuspension}',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(color: Colors.black),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Colors',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 18,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            BuildButtonColumn(
                                Colors.black, Icons.circle, 'Black'),
                            BuildButtonColumn(
                                Colors.blueGrey, Icons.circle, 'Blue Grey'),
                            BuildButtonColumn(
                                Colors.yellow, Icons.circle, 'Yellow'),
                            BuildButtonColumn(
                                Colors.green, Icons.circle, 'Green'),
                          ]),
                      Divider(color: Colors.black),
                      RaisedButton(
                        padding: EdgeInsets.all(15),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Carreviews();
                          }));
                        },
                        child: Text(
                          'Reviews',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.white),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}

Column BuildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    ],
  );
}
