import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/showrooms.dart';

class Carshowroomadmin extends StatefulWidget {
  static const routeName = '/showroom-admin';
  @override
  _CarshowroomadminState createState() => _CarshowroomadminState();
}

class _CarshowroomadminState extends State<Carshowroomadmin> {
  // bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Manage Your Showrooms"),
        // !isSearch
        //     ? Text("admin showroom")
        //     : TextField(
        //         style: TextStyle(color: Colors.white),
        //         decoration: InputDecoration(
        //             icon: Icon(Icons.edit), hintText: "search showroom Here")),
        // actions: <Widget>[
        //   isSearch
        //       ? IconButton(
        //           icon: Icon(Icons.cancel),
        //           onPressed: () {
        //             setState(() {
        //               this.isSearch = false;
        //             });
        //           },
        //         )
        //       : IconButton(
        //           icon: Icon(Icons.search),
        //           onPressed: () {
        //             setState(() {
        //               this.isSearch = true;
        //             });
        //           },
        //         )
        // ],
      ),
      drawer: AdminDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10, 180, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("Check Out The Latest Cars ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 240, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("In The System : ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 80),
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/carlist");
                },
                color: Colors.redAccent[400],
                textColor: Colors.white,
                child: Text("Cars List", style: TextStyle(fontSize: 23)),
                padding: EdgeInsets.all(30),
                //shape: CircleBorder(),
              )),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50.0),
              child: RichText(
                text: TextSpan(
                  text: "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 40),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Admin',
                        style: TextStyle(color: Colors.redAccent[400])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// class Car extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(10.0),
//       padding: EdgeInsets.all(15.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(width: 2, color: Colors.black45),
//         borderRadius: BorderRadius.circular(5.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(right: 30.0),
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(width: 2, color: Colors.black),
//               image: DecorationImage(
//                   image: AssetImage('assets/logo.png'), fit: BoxFit.fill),
//             ),
//           ),
//           Text('Car model', style: TextStyle(fontSize: 25, color: Colors.blue)),
//           Padding(
//             padding: const EdgeInsets.only(left: 60.0),
//           ),
//           IconButton(
//             icon: Icon(Icons.add),
//             color: Colors.lightBlue,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
