import 'package:car_qr/Screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Screens/authenticate/sign_in.dart';
import 'package:car_qr/Screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // bool showSignIn = true;
  // void toggleView() {
  //   setState(() => showSignIn = !showSignIn);
  // }

  @override
  Widget build(BuildContext context) {
    // if (showSignIn) {
    //   return SignIn(toggleView: toggleView);
    // } else {
    //   return Register(toggleView: toggleView);
    // }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue[800],
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.60,
                child: Center(
                  child: Image.asset(
                    'assets/images/car_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    color: Color(0xFFF3F3F5),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Login With',
                              style: TextStyle(
                                  color: Color(0xFF0F2E48),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GestureDetector(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/facebook.png')),
                                      onTap: () {},
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/google.png')),
                                      onTap: () {},
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/user_password.png')),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (_buildContext) => SignIn(),
                                        ));
                                      },
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'You dot not have an account?' + '\n',
                                    style: TextStyle(
                                        color: Color(0xFF0F2E48),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15)),
                                TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF0F2E48),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ]),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_buildContext) => Register(),
                            ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
