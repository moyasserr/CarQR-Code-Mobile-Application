import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Providers/showrooms.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/car_description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Showroomdetails extends StatefulWidget {
  static const routeName = '/showroomdetails';

  @override
  _ShowroomdetailsState createState() => _ShowroomdetailsState();
}

class _ShowroomdetailsState extends State<Showroomdetails> {
  List<String> showroomdetails = [];
  CarShowRoom shcar;
  bool isloading = true;
  Car car;
  Future<void> test() async {
    for (var i = 0; i < shcar.stockCars.length; i++) {
      // var x = shcar.stockCars[i].price;
      shcar.stockCars[i] =
          await Provider.of<AvailableCarsModel>(context, listen: false)
              .findById(shcar.stockCars[i].id);
      print("carbrand : ${shcar.stockCars[i].carBrand}");
      // shcar.stockCars[i].price = x;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this.test().then((value) {
        setState(() {
          isloading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    shcar = ModalRoute.of(context).settings.arguments as CarShowRoom;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: new Text(
            // '${shcar.showRoomName[0].toUpperCase()}${shcar.showRoomName.substring(1)}',
            'sadsaadsdassda',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: isloading
            ? CircularProgressIndicator()
            : ListView(
                children: [
                  Column(
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
                              border:
                                  Border.all(width: 2, color: Colors.blue[900]),
                              image: DecorationImage(
                                  image: new NetworkImage(shcar.image),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PhoneNumber: ${shcar.phoneNumber}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(color: Colors.blue),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Container(
                                width: 200.0,
                                child: Text(
                                  'Location:  ${shcar.location}',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(color: Colors.blue),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              )
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
                              'Availble Cars: ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Colors.red[900]),
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < shcar.stockCars.length; i++)
                        Showroomcars(
                          carId: shcar.stockCars[i].id,
                          carbrand: shcar.stockCars[i].carBrand,
                          carimage: shcar.stockCars[i].image,
                          carmodel: shcar.stockCars[i].carModel,
                          carprice: shcar.stockCars[i].price,
                        )
                    ],
                  ),
                ],
              ));
  }
}

class Showroomcars extends StatelessWidget {
  String carId;
  String carbrand;
  String carmodel;
  String carimage;
  String carprice;
  Showroomcars(
      {this.carId, this.carbrand, this.carimage, this.carmodel, this.carprice});
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
                carbrand,
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
                carmodel,
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
                carprice,
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return CarDetails();
            // }));
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
