import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Providers/history_provider.dart';
import 'package:car_qr/Widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'car_description.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';

class History extends StatefulWidget {
  static const routeName = '/history';
  final User user;
  History({@required this.user});
  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  bool isSearch = false;
  List<Car> hCars;
  Car car;

  Future<void> getcars(BuildContext context) async {
    await Provider.of<HistoryProvider>(context, listen: false)
        .readCarHistory(widget.user.fireID);
    hCars = await Provider.of<HistoryProvider>(context, listen: false).cars;

    for (int i = 0; i < hCars.length; i++) {
      car = await Provider.of<AvailableCarsModel>(context, listen: false)
          .findById(hCars[i].id);
      hCars[i] = car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearch
            ? Text("History")
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
      drawer: AppDrawer(user: widget.user),
      body: FutureBuilder<Object>(
          future: getcars(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : hCars == null
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
                        onRefresh: () => getcars(context),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Consumer<HistoryProvider>(
                            builder: (context, carsdata, child) =>
                                ListView.builder(
                              itemCount: carsdata.cars.length,
                              itemBuilder: (_, i) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarDetails(
                                              loggedUser: widget.user,
                                              carId: carsdata.cars[i].id),
                                        ),
                                      );
                                    },
                                    child: HistoryCarList(
                                      id: carsdata.cars[i].id,
                                      carbrand: carsdata.cars[i].carBrand,
                                      carimage: carsdata.cars[i].image,
                                      carmodel: carsdata.cars[i].carModel,
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

class HistoryCarList extends StatelessWidget {
  String carbrand;
  String carmodel;
  String id;
  String carimage;
  HistoryCarList({this.id, this.carbrand, this.carimage, this.carmodel});

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
