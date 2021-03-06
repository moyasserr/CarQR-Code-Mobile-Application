import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Widgets/app_drawer.dart';
import 'package:car_qr/Widgets/car_list_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarlistUser extends StatefulWidget {
  static const routeName = '/carlist';
  final User loggedUser;

  CarlistUser({@required this.loggedUser});
  @override
  State<StatefulWidget> createState() {
    return CarlistUserState(loggedUser: loggedUser);
  }
}

class CarlistUserState extends State<CarlistUser> {
  bool isSearch = false;
  final User loggedUser;
  final myController = TextEditingController();

  CarlistUserState({@required this.loggedUser});

  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(search);
  }

  Future<void> getcars(BuildContext context) async {
    await Provider.of<AvailableCarsModel>(context, listen: false).readCars();
  }

  void search() {
    print("test test test test");
    Provider.of<AvailableCarsModel>(context, listen: false)
        .searchCars(myController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !isSearch
            ? Text("App Car List")
            : TextField(
                controller: myController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(Icons.edit), hintText: "Search Cars Here"),
              ),
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
      drawer: AppDrawer(user: loggedUser),
      body: FutureBuilder<Object>(
          future: getcars(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => getcars(context),
                    child: Container(
                      child: Consumer<AvailableCarsModel>(
                        builder: (context, cars, child) => CarListUser(
                          cars: cars.allCars,
                          loggedUser: loggedUser,
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
