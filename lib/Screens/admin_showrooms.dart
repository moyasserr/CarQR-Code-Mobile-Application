import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_showroom.dart';

class AdminShowroomsScreen extends StatelessWidget {
  static const routeName = '/adminshowrooms';

  Future<void> refresh(BuildContext context) async {
    await Provider.of<CarShowrooms>(context, listen: false).fetchShowrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Showrooms'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, ManageShowroom.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
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
                        builder: (context, showroomsData, child) =>
                            ListView.builder(
                          itemCount: showroomsData.showrooms.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              AdminShowroomItem(
                                showroomsData.showrooms[i].id,
                                showroomsData.showrooms[i].showRoomName,
                                showroomsData.showrooms[i].image,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}

class AdminShowroomItem extends StatelessWidget {
  final String id;
  final String showroomName;
  final String image;

  AdminShowroomItem(this.id, this.showroomName, this.image);

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
    return ListTile(
      title: Text(showroomName),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, ManageShowroom.routeName,
                    arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                createDialog(context);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
