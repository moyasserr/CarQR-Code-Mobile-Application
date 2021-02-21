import 'package:car_qr/Models/showroom.dart';
import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_showroom.dart';

class AdminShowroomsScreen extends StatefulWidget {
  static const routeName = '/adminshowrooms';
  static bool isloading = false;
  static CarShowRoom test;
  @override
  _AdminShowroomsScreenState createState() => _AdminShowroomsScreenState();
}

class _AdminShowroomsScreenState extends State<AdminShowroomsScreen> {
  Future<void> refresh(BuildContext context) async {
    await Provider.of<CarShowrooms>(context, listen: false)
        .fetchAdminShowroom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Showroom Profile'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.pushNamed(context, ManageShowroom.routeName);
          //     },
          //   ),
          // ],
        ),
        drawer: AdminDrawer(),
        body: FutureBuilder<Object>(
            future: refresh(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : AdminShowroomsScreen.isloading
                      ? RefreshIndicator(
                          onRefresh: () => refresh(context),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Consumer<CarShowrooms>(
                              builder: (context, showroomdata, child) =>
                                  AdminShowroomItem(
                                showroomdata.showroom.id,
                                showroomdata.showroom.showRoomName,
                                showroomdata.showroom.phoneNumber,
                                showroomdata.showroom.location,
                                showroomdata.showroom.image,
                              ),
                            ),
                          ))
                      : Center(
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black54,
                                offset: Offset(2, 6),
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ManageShowroom.routeName);
                              },
                            ),
                          ),
                        ));
              // : RefreshIndicator(
              //     onRefresh: () => refresh(context),
              //     child: Padding(
              //       padding: EdgeInsets.all(8),
              //       child: Consumer<CarShowrooms>(
              //         builder: (context, showroomsData, child) =>
              //             ListView.builder(
              //           itemCount: showroomsData.showrooms.length,
              //           itemBuilder: (_, i) => Column(
              //             children: [
              //               AdminShowroomItem(
              //                 showroomsData.showrooms[i].id,
              //                 showroomsData.showrooms[i].showRoomName,
              //                 showroomsData.showrooms[i].image,
              //               ),
              //               Divider(),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   );
            }));
  }
}

class AdminShowroomItem extends StatelessWidget {
  final String id;
  final String showroomName;
  final String phonenumber;
  final String address;
  final String image;

  AdminShowroomItem(
      this.id, this.showroomName, this.phonenumber, this.address, this.image);

  Future<void> createDialog(BuildContext context) async {
    final scaffold = Scaffold.of(context);
    final prov = Provider.of<CarShowrooms>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete this showroom ?"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () async {
                  try {
                    prov.deleteShowroom(id);
                    Navigator.of(context).pop();
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Deleting failed!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    print(error);
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Showroom Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.0),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 16.0,
                                      child: new Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ManageShowroom.routeName,
                                          arguments: id);
                                    },
                                  )
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.red[600],
                                      radius: 16.0,
                                      child: new Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                    onTap: () {
                                      createDialog(context);
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Showroom Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  showroomName,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'PhoneNumber',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  phonenumber,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  address,
                                ),
                              ),
                            ],
                          )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 25.0),
                      //     child: new Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Expanded(
                      //           child: Container(
                      //             child: new Text(
                      //               'Pin Code',
                      //               style: TextStyle(
                      //                   fontSize: 16.0,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //         Expanded(
                      //           child: Container(
                      //             child: new Text(
                      //               'State',
                      //               style: TextStyle(
                      //                   fontSize: 16.0,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //       ],
                      //     )),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 25.0, right: 25.0, top: 2.0),
                      //     child: new Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: Padding(
                      //             padding: EdgeInsets.only(right: 10.0),
                      //             child: new TextField(
                      //               decoration: const InputDecoration(
                      //                   hintText: "Enter Pin Code"),
                      //               //enabled: !_status,
                      //             ),
                      //           ),
                      //           flex: 2,
                      //         ),
                      //         Flexible(
                      //           child: new TextField(
                      //             decoration: const InputDecoration(
                      //                 hintText: "Enter State"),
                      //             //enabled: !_status,
                      //           ),
                      //           flex: 2,
                      //         ),
                      //       ],
                      //     )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //     title: Text(showroomName),
  //     leading: CircleAvatar(
  //       backgroundImage: NetworkImage(image),
  //     ),
  //     trailing: Container(
  //       width: 100,
  //       child: Row(
  //         children: <Widget>[
  //           IconButton(
  //             icon: Icon(Icons.edit),
  //             onPressed: () {
  //               Navigator.pushNamed(context, ManageShowroom.routeName,
  //                   arguments: id);
  //             },
  //             color: Theme.of(context).primaryColor,
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.delete),
  //             onPressed: () {
  //               createDialog(context);
  //             },
  //             color: Theme.of(context).errorColor,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
