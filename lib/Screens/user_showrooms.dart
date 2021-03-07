import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Screens/showroom_details.dart';
import 'package:car_qr/Widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserShowrooms extends StatefulWidget {
  static const routeName = '/usershowrooms';
  final User user;
  UserShowrooms({@required this.user});
  @override
  _UserShowroomsState createState() => _UserShowroomsState();
}

class _UserShowroomsState extends State<UserShowrooms> {
  Future<void> refresh(BuildContext context) async {
    await Provider.of<CarShowrooms>(context, listen: false).fetchShowrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Car Showrooms'),
          backgroundColor: Colors.blue[800],
        ),
        drawer: AppDrawer(user: widget.user),
        body: FutureBuilder<Object>(
            future: refresh(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => refresh(context),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Consumer<CarShowrooms>(
                          builder: (context, showroomdata, child) =>
                              ListView.builder(
                            itemCount: showroomdata.showrooms.length,
                            itemBuilder: (_, i) => Column(
                              children: [
                                Showrooms(
                                  id: showroomdata.showrooms[i].id,
                                  showroomName:
                                      showroomdata.showrooms[i].showRoomName,
                                  image: showroomdata.showrooms[i].image,
                                  phonenumber:
                                      showroomdata.showrooms[i].phoneNumber,
                                  address: showroomdata.showrooms[i].location,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ));
            }));
  }
}

class Showrooms extends StatelessWidget {
  final String id;
  final String showroomName;
  final String phonenumber;
  final String address;
  final String image;

  Showrooms(
      {this.id, this.showroomName, this.phonenumber, this.address, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Showroomdetails.routeName,
              arguments: [showroomName, phonenumber, address, image, id]);
        },
        child: Card(
          elevation: 10.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            // height: 150,
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                    image: DecorationImage(
                        image: new NetworkImage(image), fit: BoxFit.fill),
                  ),
                ),
                title: Text(
                  '${showroomName[0].toUpperCase()}${showroomName.substring(1)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.car_repair, color: Colors.yellowAccent),
                    Text(" Showroom", style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0)),
          ),
        ));
  }
}
