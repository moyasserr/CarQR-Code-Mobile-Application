import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Models/showrooms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class ManageShowroom extends StatefulWidget {
  @override
  _ManageShowroomState createState() => _ManageShowroomState();
}

class _ManageShowroomState extends State<ManageShowroom> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final imageController = TextEditingController();
  final imageFocusNode = FocusNode();
  final locationFocusNode = FocusNode();
  final phonenumberFocusNode = FocusNode();
  Future<File> file;
  String base64Image;
  File tmpFile;
  String _uploadedFileURL;
  var editShowroom = CarShowRoom(
    id: null,
    showRoomName: '',
    phoneNumber: '',
    location: '',
    image: '',
  );
  var intialValues = {
    'showRoomName': '',
    'phoneNumber': '',
    'location': '',
    'image': '',
  };

  var isloading = false;
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final showroomId = ModalRoute.of(context).settings.arguments as String;
      if (showroomId != null) {
        editShowroom = Provider.of<CarShowrooms>(context, listen: false)
            .findById(showroomId);
        intialValues = {
          'showRoomName': editShowroom.showRoomName,
          'phoneNumber': editShowroom.phoneNumber,
          'location': editShowroom.location,
          'image': '',
        };
        imageController.text = editShowroom.image;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    imageFocusNode.addListener(updateImg);
    super.initState();
  }

  @override
  void dispose() {
    phonenumberFocusNode.dispose();
    locationFocusNode.dispose();
    imageFocusNode.removeListener(updateImg);
    imageFocusNode.dispose();
    super.dispose();
  }

  void updateImg() {
    if (!imageFocusNode.hasFocus) {
      if ((!imageController.text.startsWith('http') &&
              !imageController.text.startsWith('https')) ||
          (!imageController.text.endsWith('.png') &&
              !imageController.text.endsWith('.jpg') &&
              !imageController.text.endsWith('.jpeg'))) {
        return;
      }
    }
  }

  Future<void> formSetup() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isloading = true;
    });
    if (editShowroom.id != null) {
      print("image path is:$editShowroom.image");
      await uploadFile();
      await Provider.of<CarShowrooms>(context, listen: false)
          .updateShowroom(editShowroom.id, editShowroom);
    } else {
      try {
        await uploadFile();
        await Provider.of<CarShowrooms>(context, listen: false)
            .addShowroom(editShowroom);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
        print(error);
      }
    }
    setState(() {
      isloading = false;
    });
    Navigator.of(context).pop();
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('/showroom_images/${Path.basename(tmpFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(tmpFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        editShowroom.image = _uploadedFileURL;
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
    var check = false;
    if (editShowroom.id != null) {
      check = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Showroom Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: formSetup,
          ),
        ],
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    check
                        ? Text(
                            'Edit your showroom',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          )
                        : Text(
                            'Add your showroom',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
                    new Text(
                      'Showroom Name :',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      initialValue: intialValues['showRoomName'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 3,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'Showroom Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(phonenumberFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter showroom name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editShowroom = CarShowRoom(
                            showRoomName: value,
                            phoneNumber: editShowroom.phoneNumber,
                            location: editShowroom.location,
                            image: editShowroom.image,
                            id: editShowroom.id);
                      },
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Text(
                      'PhoneNumber :',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    TextFormField(
                      initialValue: intialValues['phoneNumber'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 3,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'PhoneNumber',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: phonenumberFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(locationFocusNode);
                      },
                      validator: (value) {
                        Pattern pattern = r'^(?:[+0]9)?[0-9]{11}$';
                        RegExp regex = new RegExp(pattern);
                        if (value.isEmpty) {
                          return 'Please enter phone number.';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Enter Valid Phone Number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editShowroom = CarShowRoom(
                            showRoomName: editShowroom.showRoomName,
                            phoneNumber: value,
                            location: editShowroom.location,
                            image: editShowroom.image,
                            id: editShowroom.id);
                      },
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Text(
                      'Address :',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    TextFormField(
                      initialValue: intialValues['location'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 3,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'Address',
                      ),
                      focusNode: locationFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter address.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editShowroom = CarShowRoom(
                            showRoomName: editShowroom.showRoomName,
                            phoneNumber: editShowroom.phoneNumber,
                            location: value,
                            image: editShowroom.image,
                            id: editShowroom.id);
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
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: <Widget>[
                    //     Container(
                    //       width: 100,
                    //       height: 100,
                    //       margin: EdgeInsets.only(
                    //         top: 8,
                    //         right: 10,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 1,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //       child: imageController.text.isEmpty
                    //           ? Text('Enter a URL')
                    //           : FittedBox(
                    //               child: Image.network(
                    //                 imageController.text,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //     ),
                    //     Expanded(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(labelText: 'Image URL'),
                    //         keyboardType: TextInputType.url,
                    //         textInputAction: TextInputAction.done,
                    //         controller: imageController,
                    //         focusNode: imageFocusNode,
                    //         onFieldSubmitted: (_) {
                    //           formSetup();
                    //         },
                    //         validator: (value) {
                    //           if (value.isEmpty) {
                    //             return 'Please enter an image URL.';
                    //           }
                    //           if (!value.startsWith('http') &&
                    //               !value.startsWith('https')) {
                    //             return 'Please enter a valid URL.';
                    //           }
                    //           if (!value.endsWith('.png') &&
                    //               !value.endsWith('.jpg') &&
                    //               !value.endsWith('.jpeg')) {
                    //             return 'Please enter a valid image URL.';
                    //           }
                    //           return null;
                    //         },
                    //         onSaved: (value) {
                    //           editShowroom = CarShowRoom(
                    //               showRoomName: editShowroom.showRoomName,
                    //               phoneNumber: editShowroom.phoneNumber,
                    //               location: editShowroom.location,
                    //               image: value,
                    //               id: editShowroom.id);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
