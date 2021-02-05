import 'package:car_qr/Models/showrooms.dart';
import 'package:car_qr/Widgets/admin_my_showroom_item.dart';
import 'package:car_qr/Widgets/adminshdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminShowroomsScreen extends StatelessWidget {
  // static const routeName = '/user-products';

  Future<void> refresh(BuildContext context) async {
    Provider.of<CarShowrooms>(context, listen: false).fetchShowrooms();
  }

  @override
  Widget build(BuildContext context) {
    refresh(context);
    final showroomsData = Provider.of<CarShowrooms>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Showrooms'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.of(context).pushNamed(EditProductScreen.routeName);
              Navigator.pushNamed(context, "/manageshowroom");
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        //onRefresh: () => refresh(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
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
  }
}
