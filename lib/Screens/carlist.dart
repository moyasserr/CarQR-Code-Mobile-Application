import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';

class Carlist extends StatefulWidget {
  static const routeName = '/carlist';
  @override
  State<StatefulWidget> createState() {
    return CarlistState();
  }
}

class CarlistState extends State<Carlist> {
  bool isSearch = false;

  Future<void> getcars(BuildContext context) async {
    await Provider.of<AvailableCarsModel>(context, listen: false).readCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !isSearch
            ? Text("App Car List")
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
      drawer: AdminDrawer(),
      body: FutureBuilder<Object>(
          future: getcars(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => getcars(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<AvailableCarsModel>(
                        builder: (context, carsdata, child) => ListView.builder(
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
                    ));
          }),
    );
  }
}

class Admincarlist extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String carbrand;
  final String carmodel;
  final String id;
  final String carimage;
  Admincarlist(this.id, this.carbrand, this.carimage, this.carmodel);

  String shid;
  Car shcar;

  Future<String> createDialog(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter The Car Price"),
            content: Form(
                key: _formKey,
                child: TextFormField(
                    decoration: InputDecoration(labelText: "Car Price"),
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter car price';
                      }
                      return null;
                    })),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () {
                  final isValid = _formKey.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  _formKey.currentState.save();
                  Navigator.of(context).pop(priceController.text.toString());
                },
              )
            ],
          );
        });
  }

  Future<void> showroomdata(BuildContext context) async {
    await Provider.of<CarShowrooms>(context, listen: false)
        .fetchAdminShowroom();
    CarShowRoom x = Provider.of<CarShowrooms>(context, listen: false).showroom;
    shid = x.id;
  }

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
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.lightBlue,
            onPressed: () async {
              shcar = new Car.emptyConst(id: id, image: carimage);
              await showroomdata(context);
              createDialog(context).then((value) {
                Future.delayed(Duration(seconds: 2), () {
                  Provider.of<CarShowrooms>(context, listen: false)
                      .addcarToShowroom(shid, shcar, value);
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
