import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarlistState();
  }
}

class CarlistState extends State<Carlist> {
  bool isSearch = false;

  Future<void> getcars(BuildContext context) async {
    Provider.of<AvailableCarsModel>(context, listen: false).readCars();
  }

  @override
  Widget build(BuildContext context) {
    final carsdata = Provider.of<AvailableCarsModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !isSearch
            ? Text("Car List")
            : TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(Icons.edit), hintText: "search showroom Here")),
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
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => getcars(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: carsdata.allCars.length,
            itemBuilder: (_, i) => Column(
              children: [
                Admincarlist(
                  carsdata.allCars[i].id,
                  carsdata.allCars[i].carBrand,
                  carsdata.allCars[i].image,
                  carsdata.allCars[i].carModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Admincarlist extends StatelessWidget {
  final String carbrand;
  final String carmodel;
  final String id;
  final String carimage;
  Admincarlist(this.id, this.carbrand, this.carimage, this.carmodel);

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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(carimage),
          ),

          // Container(
          //   margin: const EdgeInsets.only(right: 30.0),
          //   width: 50,
          //   height: 50,

          //    decoration: BoxDecoration(
          //      shape: BoxShape.circle,
          //   //   border: Border.all(width: 2, color: Colors.black),
          //   //   image: DecorationImage(
          //   //       image: AssetImage('assets/logo.png'), fit: BoxFit.fill),
          //   // ),
          // ),
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

          // Padding(
          //   padding: const EdgeInsets.only(left: 60.0),
          // ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.lightBlue,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
