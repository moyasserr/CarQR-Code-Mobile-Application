import 'package:flutter/material.dart';
import 'package:car_qr/Screens/myappbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'car_description.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: MyAppBar(
            titlex: new Text(
              'History',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0),
            ),
            history: () => Navigator.pushNamed(context, '/history'),
            showrooms: () => Navigator.pushNamed(context, '/showrooms'),
            settings: () => Navigator.pushNamed(context, '/settings'),
            about: () => Navigator.pushNamed(context, '/about'),
          ),
          body: ListView(
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                    labelText: 'Search For Cars',
                  ),
                ),
              )),
              for (var i = 0; i < 4; i++) Carhistory(),
            ],
          )),
    );
  }
}

class Carhistory extends StatelessWidget {
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
