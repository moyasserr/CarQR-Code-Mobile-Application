import 'package:car_qr/Screens/addshowroom.dart';
import 'package:car_qr/Screens/carlist.dart';
import 'package:car_qr/Screens/editshowroom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/showrooms.dart';

class Abdo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CarShowrooms(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => Carshowroomadmin(),
          '/add': (context) => Addshowroom(),
          '/edit': (context) => Editshowroom(),
          '/carlist': (context) => Carlist(),
        },
      ),
    );
  }
}

void main() {
  runApp(Abdo());
}

class Carshowroomadmin extends StatefulWidget {
  @override
  _CarshowroomadminState createState() => _CarshowroomadminState();
}

class _CarshowroomadminState extends State<Carshowroomadmin> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !isSearch
            ? Text("admin showroom")
            : TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(Icons.edit), hintText: "search showroom Here")),
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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new RaisedButton(
                  child: new Text("Add"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/add");
                  },
                  color: Colors.blue,
                  highlightColor: Colors.blueGrey,
                ),
                new RaisedButton(
                  child: new Text("Edit"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit");
                  },
                  color: Colors.blue,
                  highlightColor: Colors.blueGrey,
                ),
                new RaisedButton(
                  child: new Text("Car List"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/carlist");
                  },
                  color: Colors.blue,
                  highlightColor: Colors.blueGrey,
                ),
              ],
            ),
            // for (var i = 0; i <= 2; i++) Car(),
          ],
        ),
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
