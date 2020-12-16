import 'package:flutter/material.dart';

void main() {
  runApp(AppInfo());
}

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('App Information'),
      ),
      body: ListView(padding: const EdgeInsets.all(50), children: <Widget>[
        Center(
          child: Column(children: <Widget>[
            Text(
              "Car QR Scan App",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
            Text(
              "Version 1.0",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Image.asset(
              'assets/images/porsche.png',
              width: 230.0,
              height: 150.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.copyright,
                  color: Colors.black,
                  size: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '2020 CarQR Copy Right.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ]),
    );
  }
}
