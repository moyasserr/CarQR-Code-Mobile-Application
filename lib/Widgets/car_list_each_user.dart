import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Screens/car_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/edit_car.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CarListEachUser extends StatelessWidget {
  final Car car;
  final User loggedUser;

  var modelProvider;

  CarListEachUser({@required this.car, @required this.loggedUser});
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Provider.of<AvailableCarsModel>(context).deleteCar(car.id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Are you sure you want to delete Car ${car.carBrand} ${car.carModel} from the system?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    modelProvider = Provider.of<AvailableCarsModel>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CarDetails(
                  carId: car.id,
                  loggedUser: loggedUser,
                )),
      ),
      child: Card(
        elevation: 10.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(64, 75, 96, .9),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.white),
                image: DecorationImage(
                    image: new NetworkImage(car.image), fit: BoxFit.fill),
              ),
            ),
            title: Text(
              car.carBrand.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            subtitle: Row(
              children: <Widget>[
                Text("Model : ${car.carModel.toString()}",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
          ),
        ),
      ),
    );
  }
}
