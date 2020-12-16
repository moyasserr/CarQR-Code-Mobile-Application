import 'package:flutter/material.dart';
import 'package:car_qr/Screens/signup.dart';

class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        '/signup': (context) => Signup(),
      },
      title: "Signin",
      home: Signin(),
    );
  }
}

class Signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SigninState();
  }
}

class SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Login")),
      body: new Container(
          padding: const EdgeInsets.all(20.0), child: formSetup(context)),
    );
  }

  Widget formSetup(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new ListView(
        children: <Widget>[
          new Text(
            'Login',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 30),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'Username',
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
              labelText: 'Username',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter Username";
              else if (val.length < 3)
                return "The username is too short";
              else
                return null;
            },
            onSaved: (val) => _username = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Passsword',
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
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (val) {
              if (val.length == 0)
                return "Please enter password";
              else if (val.length <= 5)
                return "Your password should be more then 6 char long";
              else
                return null;
            },
            onSaved: (val) => _password = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new RaisedButton(
            child: new Text("Login"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Processing Data..."),
                ));
              }
            },
            color: Colors.blue,
            highlightColor: Colors.blueGrey,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new RaisedButton(
            child: new Text("SignUp"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
            color: Colors.blue,
            highlightColor: Colors.blueGrey,
          ),
          new FlatButton(onPressed: () {}, child: Text('Login as a Guest')),
        ],
      ),
    );
  }
}
