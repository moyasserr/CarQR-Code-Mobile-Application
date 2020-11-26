import 'package:flutter/material.dart';

class FormValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Form validation",
      home: Signup(),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fname;
  String _lname;
  String _username;
  String _password;
  String _confpass;
  String _phoneno;
  String _email;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Signup")),
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
            'SignUp',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 30),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'First Name',
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
              labelText: 'first name',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter first name";
              else
                return null;
            },
            onSaved: (val) => _fname = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Last Name',
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
              labelText: 'last name',
            ),
            validator: (val) {
              if (val.length == 0)
                return "Please enter your last name";
              else
                return null;
            },
            onSaved: (val) => _lname = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'E-mail',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
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
              labelText: 'E-mail',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val.length == 0)
                return "Please enter email";
              else if (!val.contains("@"))
                return "Please enter valid email";
              else
                return null;
            },
            onSaved: (val) => _email = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'User Name',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 19),
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
          new Text(
            'Conferm Password',
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
              labelText: 'conferm password',
            ),
            obscureText: true,
            validator: (val) {
              var valpas = _formKey.currentState.context;
              if (val.length == 0)
                return "Please enter password";
              else {
                return null;
              }
            },
            onSaved: (val) => _confpass = val,
          ),
          new RaisedButton(
            child: new Text("Signup"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content:
                      new Text("Your email: $_email and Password: $_password"),
                ));
              }
            },
            color: Colors.blue,
            highlightColor: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}
