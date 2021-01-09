import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Models/car.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class EditCar extends StatefulWidget {
  final String carId;

  EditCar({@required this.carId});

  @override
  _EditCarState createState() => _EditCarState(carId: carId);
}

class _EditCarState extends State<EditCar> {
  List<TextEditingController> textController = new List();
  final _formKey = GlobalKey<FormState>();
  final String carId;
  Car oldCar;
  Car newCar = Car.emptyConst();

  getCar(BuildContext context) async {
    oldCar = await Provider.of<AvailableCarsModel>(context, listen: false)
        .findById(carId);
    print(oldCar.id);
  }

  _EditCarState({@required this.carId}) {
    for (var i = 0; i < 25; i++) {
      textController.add(new TextEditingController());
    }
  }

  void dispose() {
    for (var i = 0; i < textController.length; i++) {
      textController[i].dispose();
    }
    super.dispose();
  }

  onEdit() async {
    if (_formKey.currentState.validate()) {
      newCar.image = oldCar.image;
      Provider.of<AvailableCarsModel>(context, listen: false)
          .updateCar(carId, newCar);
      Navigator.pop(context);
    }
  }

  void setFields() {
    textController[0].text = oldCar.carBrand;
    textController[1].text = oldCar.carModel;
    textController[2].text = oldCar.cubicCentimeters.toString();
    textController[3].text = oldCar.horsePower.toString();
    textController[4].text = oldCar.maxSpeed.toString();
    textController[5].text = oldCar.seatsNumbers.toString();
    textController[6].text = oldCar.doorsType;
    textController[7].text = oldCar.roofType;
    textController[8].text = oldCar.manufactureCountry;
    textController[9].text = oldCar.manufactureYear.toString();
    textController[10].text = oldCar.carHeight.toString();
    textController[11].text = oldCar.carWidth.toString();
    textController[12].text = oldCar.wheelBase.toString();
    textController[13].text = oldCar.truckBase.toString();
    textController[14].text = oldCar.engineTorgue.toString();
    textController[15].text = oldCar.engineAcceleration.toString();
    textController[16].text = oldCar.fuelConsumption.toString();
    textController[17].text = oldCar.fuelTankCapacity.toString();
    textController[18].text = oldCar.prefferedFuelType;
    textController[19].text = oldCar.brakeSafety;
    textController[20].text = oldCar.brake100To0.toString();
    textController[21].text = oldCar.rimDiameter.toString();
    textController[22].text = oldCar.frontSuspension;
    textController[23].text = oldCar.backSuspension;
    textController[24].text = oldCar.wheelWidth.toString();
  }

  @override
  Widget build(BuildContext context) {
    getCar(context);
    setFields();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Car'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[0],
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
                    newCar.carBrand = oldCar.carBrand;
                  else {
                    print('Brand');
                    newCar.carBrand = val;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[1],
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
                    newCar.carModel = oldCar.carModel;
                  else {
                    print('Model');
                    newCar.carModel = val;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[2],
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
                  print('CCCC');
                  if (val.length == 0)
                    newCar.cubicCentimeters = oldCar.cubicCentimeters;
                  else {
                    newCar.cubicCentimeters = int.parse(val);
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[3],
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
                  print('HP');
                  if (val.length == 0)
                    newCar.horsePower = oldCar.horsePower;
                  else {
                    newCar.horsePower = int.parse(val);
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[4],
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
                  print(val);
                  if (val.length != 0) {
                    newCar.maxSpeed = double.parse(val);
                  } else {
                    newCar.maxSpeed = oldCar.maxSpeed;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[5],
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
                  if (val.length != 0) {
                    newCar.seatsNumbers = int.parse(val);
                  } else {
                    newCar.seatsNumbers = oldCar.seatsNumbers;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[6],
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
                  if (val.length != 0) {
                    newCar.doorsType = val;
                  } else {
                    newCar.doorsType = oldCar.doorsType;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[7],
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
                  if (val.length != 0) {
                    newCar.roofType = val;
                  } else {
                    newCar.roofType = oldCar.roofType;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[8],
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
                  if (val.length != 0) {
                    newCar.manufactureCountry = val;
                  } else {
                    newCar.manufactureCountry = oldCar.manufactureCountry;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[9],
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
                  if (val.length != 0) {
                    newCar.manufactureYear = int.parse(val);
                  } else {
                    newCar.manufactureYear = oldCar.manufactureYear;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[10],
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
                  if (val.length != 0) {
                    newCar.carHeight = double.parse(val);
                  } else {
                    newCar.carHeight = oldCar.carHeight;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[11],
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
                  if (val.length != 0) {
                    newCar.carWidth = double.parse(val);
                  } else {
                    newCar.carWidth = oldCar.carWidth;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[12],
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
                  if (val.length != 0) {
                    newCar.wheelBase = double.parse(val);
                  } else {
                    newCar.wheelBase = oldCar.wheelBase;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[13],
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
                  if (val.length != 0) {
                    newCar.truckBase = double.parse(val);
                  } else {
                    newCar.truckBase = oldCar.truckBase;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[14],
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
                  if (val.length != 0) {
                    newCar.engineTorgue = double.parse(val);
                  } else {
                    newCar.engineTorgue = oldCar.engineTorgue;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[15],
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
                  if (val.length != 0) {
                    newCar.engineAcceleration = double.parse(val);
                  } else {
                    newCar.engineAcceleration = oldCar.engineAcceleration;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[16],
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
                  if (val.length != 0) {
                    newCar.fuelConsumption = double.parse(val);
                  } else {
                    newCar.fuelConsumption = oldCar.fuelConsumption;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[17],
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
                  if (val.length != 0) {
                    newCar.fuelTankCapacity = double.parse(val);
                  } else {
                    newCar.fuelTankCapacity = oldCar.fuelTankCapacity;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[18],
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
                  if (val.length != 0) {
                    newCar.prefferedFuelType = val;
                  } else {
                    newCar.prefferedFuelType = oldCar.prefferedFuelType;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[19],
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
                  if (val.length != 0) {
                    newCar.brakeSafety = val;
                  } else {
                    newCar.brakeSafety = oldCar.brakeSafety;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[20],
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
                  if (val.length != 0) {
                    newCar.brake100To0 = double.parse(val);
                  } else {
                    newCar.brake100To0 = oldCar.brake100To0;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[21],
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
                  if (val.length != 0) {
                    newCar.rimDiameter = double.parse(val);
                  } else {
                    newCar.rimDiameter = oldCar.rimDiameter;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[22],
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
                  if (val.length != 0) {
                    newCar.frontSuspension = val;
                  } else {
                    newCar.frontSuspension = oldCar.frontSuspension;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[23],
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
                  if (val.length != 0) {
                    newCar.backSuspension = val;
                  } else {
                    newCar.backSuspension = oldCar.backSuspension;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new TextFormField(
                controller: textController[24],
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
                  if (val.length != 0) {
                    newCar.wheelWidth = double.parse(val);
                  } else {
                    newCar.wheelWidth = oldCar.wheelWidth;
                  }
                  return null;
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              RaisedButton(
                onPressed: () => onEdit(),
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
