import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Models/car.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final carDataController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<File> file;
  String base64Image;
  File tmpFile;

  Car car = Car.emptyConst();

  void dispose() {
    carDataController.dispose();
    super.dispose();
  }

  void onAdd() {
    if (_formKey.currentState.validate()) {
      car.image = 'assets/images/instaicon.png';
      Provider.of<AvailableCarsModel>(context, listen: false).addCar(car);
      Navigator.pop(context);
    }
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print(tmpFile);
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              width: 100,
              height: 100,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Car Brand (required)',
              ),
              validator: (val) {
                if (val.length == 0)
                  return "Please enter Car Brand";
                else {
                  car.carBrand = val;
                  return null;
                }
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Car Model (required)',
              ),
              validator: (val) {
                if (val.length == 0)
                  return "Please enter Car Model";
                else {
                  car.carModel = val;
                  return null;
                }
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'CC (required)',
              ),
              validator: (val) {
                if (val.length == 0)
                  return "Please enter CC";
                else {
                  car.cubicCentimeters = int.parse(val);
                  return null;
                }
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Horse Power (required)',
              ),
              validator: (val) {
                if (val.length == 0)
                  return "Please enter Horse Power";
                else {
                  car.horsePower = int.parse(val);
                  return null;
                }
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Max Speed',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Seats Number',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Doors Type',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Roof Type ',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Manufacture Country',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Manufacture Year ',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Car Height',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Car Width',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Wheel Base',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Truck Base',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Engine Torgue',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Engine Acceleration',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Fuel Consumption',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Fuel Tank Capacity',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Preffered Fuel Type',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Brake Safety',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Brake 100 To 0',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Rim Diameter',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Front Suspension',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Back Suspension',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 3,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Wheel Width',
              ),
              validator: (val) {
                return null;
              },
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                showImage(),
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 20.0,
                  onPressed: chooseImage,
                ),
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            RaisedButton(
              onPressed: () => onAdd(),
              child: Text('ADD'),
            )
          ],
        ),
      ),
    );
  }
}
