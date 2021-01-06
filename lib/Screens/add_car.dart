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

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  List<TextEditingController> textController = new List();
  final _formKey = GlobalKey<FormState>();
  Future<File> file;
  String base64Image;
  File tmpFile;
  String _uploadedFileURL;

  Car car = Car.emptyConst();

  _AddCarState() {
    for (var i = 0; i < 25; i++) {
      textController.add(new TextEditingController());
    }
  }

  @override
  void initState() {
    print(textController.length);
    super.initState();
  }

  void dispose() {
    for (var i = 0; i < textController.length; i++) {
      textController[i].dispose();
    }
    super.dispose();
  }

  onAdd() async {
    if (_formKey.currentState.validate()) {
      await uploadFile();
      print(_uploadedFileURL);
      Provider.of<AvailableCarsModel>(context, listen: false).addCar(car);
      Navigator.pop(context);
    }
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('/cars_images/${Path.basename(tmpFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(tmpFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        car.image = _uploadedFileURL;
      });
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
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
                    return "Please enter Car Brand";
                  else {
                    print('Brand');
                    car.carBrand = val;
                    return null;
                  }
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
                    return "Please enter Car Model";
                  else {
                    print('Model');
                    car.carModel = val;
                    return null;
                  }
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
                    car.maxSpeed = double.parse(val);
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
                    car.seatsNumbers = int.parse(val);
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
                    car.doorsType = val;
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
                    car.roofType = val;
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
                    car.manufactureCountry = val;
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
                    car.manufactureYear = int.parse(val);
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
                    car.carHeight = double.parse(val);
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
                    car.carWidth = double.parse(val);
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
                    car.wheelBase = double.parse(val);
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
                    car.truckBase = double.parse(val);
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
                    car.engineTorgue = double.parse(val);
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
                    car.engineAcceleration = double.parse(val);
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
                    car.fuelConsumption = double.parse(val);
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
                    car.fuelTankCapacity = double.parse(val);
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
                    car.prefferedFuelType = val;
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
                    car.brakeSafety = val;
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
                    car.brake100To0 = double.parse(val);
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
                    car.rimDiameter = double.parse(val);
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
                    car.frontSuspension = val;
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
                    car.backSuspension = val;
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
                    car.wheelWidth = double.parse(val);
                  }
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
              FloatingActionButton(
                onPressed: () => onAdd(),
                child: Text('ADD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
