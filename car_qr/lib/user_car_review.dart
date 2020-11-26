import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';

class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "car review",
      home: Ucarreview(),
    );
  }
}

class Ucarreview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UcarreviewState();
  }
}

class UcarreviewState extends State<Ucarreview> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fullname;
  String _password;
  double _rating = 1;
  double count = 1;

  get rating => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Review")),
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
            'Review',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 30),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'Full name',
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
              labelText: 'Full name',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter your name";
              else
                return null;
            },
            onSaved: (val) => _fullname = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Rating',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          GFRating(
            color: Colors.yellow,
            value: _rating,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'Comment',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
          ),
          new TextField(
            style: TextStyle(height: 3.0),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 3,
                  style: BorderStyle.none,
                ),
              ),
              labelText: 'write your comment',
            ),
          ),
          new RaisedButton(
            child: new Text("Submit"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _scaffoldKey.currentState.showSnackBar(new SnackBar());
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
