import 'package:car_qr/myappbar.dart';
import 'package:flutter/material.dart';

class ShowroomAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(
          titlex: new Text(
            'Car Showroom name',
            style: TextStyle(fontSize: 22.0),
          ),
          history: () => Navigator.pushNamed(context, '/history'),
          showrooms: () => Navigator.pushNamed(context, '/showrooms'),
          settings: () => Navigator.pushNamed(context, '/settings'),
          about: () => Navigator.pushNamed(context, '/about'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 80, bottom: 100),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      margin: const EdgeInsets.only(left: 30.0),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2, color: Color.fromRGBO(32, 150, 243, 1)),
                        image: DecorationImage(
                            image: AssetImage('assets/logo.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: RichText(
                              text: TextSpan(
                                text: 'hei ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'bold',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: ' world!'),
                                ],
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Hello ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'bold',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: ' world!'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.blue,
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    'Edit Showroom \n  Information',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)),
                    color: Colors.blue,
                    onPressed: () {
                      /*...*/
                    },
                    child: Text(
                      'Car List',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
