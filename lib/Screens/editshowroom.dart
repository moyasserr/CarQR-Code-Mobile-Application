import 'package:flutter/material.dart';

class Editshowroom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditshowroomState();
  }
}

class EditshowroomState extends State<Editshowroom> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;
  String _number;
  String _address;

  get rating => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Edit Showroom")),
      body: new Container(
          padding: const EdgeInsets.all(20.0), child: formSetup(context)),
    ));
  }

  Widget formSetup(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new ListView(
        children: <Widget>[
          new Text(
            'Edit your showroom',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 30),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'Name',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
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
              labelText: 'Showroom Name',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter your Showroom  name";
              else
                return null;
            },
            onSaved: (val) => _name = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Number',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
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
              labelText: 'Showroom Number',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter your Showroom  Number";
              else
                return null;
            },
            onSaved: (val) => _number = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Address',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
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
              labelText: 'Address',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter your Showroom  Address";
              else
                return null;
            },
            onSaved: (val) => _address = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new RaisedButton(
            child: new Text("Add"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Your review have been submited"),
                ));
              }
            },
            color: Colors.blue,
            highlightColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
