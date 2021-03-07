import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Models/showrooms.dart';
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
  CarShowRoom showroom;
  Car car;
  Future<void> getshcars(BuildContext context) async {
    showroomdetails = ModalRoute.of(context).settings.arguments as List<String>;
    showroom = await Provider.of<CarShowrooms>(context, listen: false)
        .findshowroom(showroomdetails[4]);

    await Provider.of<CarShowrooms>(context, listen: false)
        .fetchShowroomCars(showroomdetails[4]);
    print("test ${showroom.stockCars.length}");
    // print("sasasasas${showroomdetails[4]}");
    // for (int i = 0; i < showroom.stockCars.length; i++) {
    //   car = await Provider.of<AvailableCarsModel>(context, listen: false)
    //       .findById(showroom.stockCars[i].id);
    //   car.price = showroom.stockCars[i].price;
    //   showroom.stockCars[i] = car;
    // }
  }

  @override
  Widget build(BuildContext context) {
    showroomdetails = ModalRoute.of(context).settings.arguments as List<String>;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: new Text(
            '${showroomdetails[0][0].toUpperCase()}${showroomdetails[0].substring(1)}',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        // body: Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           padding: EdgeInsets.all(20.0),
        //           margin: const EdgeInsets.all(15.0),
        //           width: 100,
        //           height: 100,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             border: Border.all(width: 2, color: Colors.blue[900]),
        //             image: DecorationImage(
        //                 image: new NetworkImage(showroomdetails[3]),
        //                 fit: BoxFit.fill),
        //           ),
        //         ),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'PhoneNumber: ${showroomdetails[1]}',
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.lato(
        //                 textStyle: TextStyle(color: Colors.blue),
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w700,
        //                 fontStyle: FontStyle.italic,
        //               ),
        //             ),
        //             Container(
        //               width: 200.0,
        //               child: Text(
        //                 'Location:  ${showroomdetails[2]}',
        //                 textAlign: TextAlign.center,
        //                 overflow: TextOverflow.fade,
        //                 style: GoogleFonts.lato(
        //                   textStyle: TextStyle(color: Colors.blue),
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w700,
        //                   fontStyle: FontStyle.italic,
        //                 ),
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Container(
        //           padding: EdgeInsets.all(20.0),
        //           margin: EdgeInsets.symmetric(vertical: 15.0),
        //           child: Text(
        //             'Availble Cars: ',
        //             textAlign: TextAlign.center,
        //             style: GoogleFonts.lato(
        //               textStyle: TextStyle(color: Colors.red[900]),
        //               fontSize: 22,
        //               fontWeight: FontWeight.w700,
        //               fontStyle: FontStyle.italic,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        body: FutureBuilder<Object>(
            future: getshcars(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : showroom.stockCars == null
                      ? Center(
                          child: Text(
                            "No Cars Added Yet",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.blue),
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => getshcars(context),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Consumer<CarShowrooms>(
                              builder: (context, carsdata, child) =>
                                  ListView.builder(
                                itemCount: carsdata.showroom.stockCars.length,
                                itemBuilder: (_, i) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CarDetails(
                                                carId: carsdata
                                                    .showroom.stockCars[i].id),
                                            settings: RouteSettings(
                                              arguments:
                                                  showroom.stockCars[i].price,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Showroomcars(
                                        id: carsdata.showroom.stockCars[i].id,
                                        carbrand: carsdata
                                            .showroom.stockCars[i].carBrand,
                                        carimage: carsdata
                                            .showroom.stockCars[i].image,
                                        carmodel: carsdata
                                            .showroom.stockCars[i].carModel,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
            }));
  }
}

class Showroomcars extends StatelessWidget {
  String carbrand;
  String carmodel;
  String id;
  String carimage;
  Showroomcars({this.id, this.carbrand, this.carimage, this.carmodel});
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
