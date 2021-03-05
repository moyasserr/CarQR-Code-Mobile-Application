import 'package:flutter/material.dart';

void main() {
  runApp(TermsConditions());
}

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: ListView(padding: const EdgeInsets.all(50), children: <Widget>[
        Center(
          child: Column(children: <Widget>[
            Text(
              "PRIVACY NOTICE",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
              ),
            ),
            Text(
              "Last updated February 24, 2021",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              "When you use our mobile application, as the case may be (the App) and more generally, use any of our services (the Services which include the App), we appreciate that you are trusting us with your personal information. We take your privacy very seriously. In this privacy notice, we seek to explain to you in the clearest way possible what information we collect, how we use it and what rights you have in relation to it. We hope you take some time to read through it carefully, as it is important. If there are any terms in this privacy notice that you do not agree with, please discontinue use of our Services immediately. This privacy notice applies to all information collected through our Services (which, as described above, includes our App), as well as, any related services, sales, marketing or events.Please read this privacy notice carefully as it will help you understand what we do with the information that we collect.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
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
