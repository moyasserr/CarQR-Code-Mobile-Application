import 'package:flutter/material.dart';

class CarDetails extends StatefulWidget {
  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Car Description'),
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        Center(
          child: FadeTransition(
            opacity: animation,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/porsche.png',
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
                        'Porsche',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '911 Carrera',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BuildButtonColumn(
                                Colors.white, Icons.time_to_leave, '2500CC'),
                            BuildButtonColumn(
                                Colors.white, Icons.toys, '500HP'),
                            BuildButtonColumn(
                                Colors.white, Icons.auto_fix_high, 'Automatic'),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BuildButtonColumn(
                                Colors.white, Icons.speed, '320 KM/H'),
                            BuildButtonColumn(
                                Colors.white, Icons.list_alt, 'Coupe'),
                            BuildButtonColumn(
                                Colors.white, Icons.airline_seat_flat, '2'),
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
                Text(
                  'Price: 300,000\$',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Year of manufacture: 2021',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Country of manufacture: Germany',
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
                  'Height: 0.7 M',
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
                  'Width: 1.3 M',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Wheel Base: 2.1 M',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Wheel Base: 2.1 M',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Trunk Space: 310 L',
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
                  'Torque: 630 NM',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Acceleration: 3.1 Seconds ',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Maximum Speed: 320 KM/h',
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
                  'Fuel Tank: 50 L',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Fuel Consumption: 11.4 L in 100 KM',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Fuel Type: Gasoline 95',
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
                  'Brake Duration from 100 to 0: 2.1 Seconds',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Brake Safety: ABS, EBD, ESP',
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
                  'Width: 52 Inch',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Rim Diameter; 40 Inch',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Front Suspension: MacPherson',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 18,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Back Suspension: Multi-Link',
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
                      BuildButtonColumn(Colors.black, Icons.circle, 'Black'),
                      BuildButtonColumn(
                          Colors.blueGrey, Icons.circle, 'Blue Grey'),
                      BuildButtonColumn(Colors.yellow, Icons.circle, 'Yellow'),
                      BuildButtonColumn(Colors.green, Icons.circle, 'Green'),
                    ]),
                Divider(color: Colors.black),
                Container(
                    width: 100.0,
                    height: 40.0,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff2c2c2c),
                    ),
                    child: Column(children: <Widget>[
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ])),
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
