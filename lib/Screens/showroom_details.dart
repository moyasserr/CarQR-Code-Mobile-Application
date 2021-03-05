import 'package:car_qr/Screens/car_description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Showroomdetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: new Text(
          'Car Showroom Name',
          style: TextStyle(fontSize: 22.0),
        ),
        
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(15.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2, color: Color.fromRGBO(32, 150, 243, 1)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PhoneNumber: 01000775996',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.blue),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Location:',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.blue),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Latest Cars: ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(color: Colors.blue),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          for (var i = 0; i < 3; i++) Showroomcars(),
        ],
      ),
    ));
  }
}

class Showroomcars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                'Car Name',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.blue),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                'Car Model',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.blue),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                'Car Price',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.blue),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CarDetails();
            }));
          },
          child: Container(
            child: Text(
              'Car Image',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.blue),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            width: 180.0,
            margin: const EdgeInsets.all(10.0),
            padding: EdgeInsets.all(45.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.black45),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
