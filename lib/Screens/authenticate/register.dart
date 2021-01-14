import 'package:flutter/material.dart';
import 'package:car_qr/Providers/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey =GlobalKey <FormState>();

  String email='';
  String password='';
  String error='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign up"),
      
      actions: <Widget>[
          FlatButton.icon(textColor: Colors.white,
            onPressed:(){
              widget.toggleView();
          } ,
           icon: Icon(Icons.person),
            label: Text('Sign in'))
        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.black12,width:2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.blue,width:2.0)
                  )
                ),
                validator: (val)=>val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() =>email =val );
                },
              ),
              SizedBox(height:20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.black12,width:2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.blue,width:2.0)
                  )
                ),
                validator: (val)=>val.length<6 ? 'Enter a password longer than 6 characters' : null,
                onChanged: (val){
                  setState(() =>password =val );
                },
              ),
              SizedBox(height:20.0),
              RaisedButton(
                padding: EdgeInsets.all(15),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                child: Text(
                  'Register',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() => error='Please enter a valid email');
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(error, style: TextStyle(color: Colors.red,fontSize: 14.0),)

            ],
          ),
        ),
      ),
    );
  }
}