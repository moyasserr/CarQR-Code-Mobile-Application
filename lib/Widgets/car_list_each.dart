import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Screens/edit_car.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CarListEach extends StatelessWidget {
  final Car car;

  var modelProvider;

  CarListEach({@required this.car});
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
            builder: (context) => EditCar(
                  carId: car.id,
                )),
      ),
      child: Card(
        child: ListTile(
          leading: Image.network(
            car.image,
            width: 100.0,
            height: 100.0,
          ),
          title: Text(car.carBrand.toString()),
          subtitle: Text(car.carModel.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: Container(
                          width: 300,
                          height: 300,
                          child: QrImage(
                            data: car.id,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
