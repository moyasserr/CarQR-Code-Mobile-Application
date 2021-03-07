import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/car_description.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';

class AdShCarList extends StatefulWidget {
  static const routeName = '/adshcarlist';
  final User user;
  AdShCarList({@required this.user});
  @override
  _AdShCarListState createState() => _AdShCarListState();
}

class _AdShCarListState extends State<AdShCarList> {
  bool isSearch = false;
  String shid;
  CarShowRoom showroom;
  Car car;
  Future<void> getshcars(BuildContext context) async {
    await Provider.of<CarShowrooms>(context, listen: false)
        .fetchAdminShowroom();
    showroom = await Provider.of<CarShowrooms>(context, listen: false).showroom;
    shid = showroom.id;
    await Provider.of<CarShowrooms>(context, listen: false)
        .fetchShowroomCars(shid);

    for (int i = 0; i < showroom.stockCars.length; i++) {
      car = await Provider.of<AvailableCarsModel>(context, listen: false)
          .findById(showroom.stockCars[i].id);
      car.price = showroom.stockCars[i].price;
      showroom.stockCars[i] = car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !isSearch
            ? Text("My Car List")
            : TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(Icons.edit), hintText: "Search Cars Here")),
        actions: <Widget>[
          isSearch
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearch = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearch = true;
                    });
                  },
                )
        ],
      ),
      drawer: AdminDrawer(user: widget.user),
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
                                    child: AdminShcarlist(
                                      id: carsdata.showroom.stockCars[i].id,
                                      carbrand: carsdata
                                          .showroom.stockCars[i].carBrand,
                                      carimage:
                                          carsdata.showroom.stockCars[i].image,
                                      carmodel: carsdata
                                          .showroom.stockCars[i].carModel,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
          }),
    );
  }
}

class AdminShcarlist extends StatelessWidget {
  String carbrand;
  String carmodel;
  String id;
  String carimage;
  AdminShcarlist({this.id, this.carbrand, this.carimage, this.carmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black45),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(carimage),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(carbrand,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  )),
              Text(carmodel,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
