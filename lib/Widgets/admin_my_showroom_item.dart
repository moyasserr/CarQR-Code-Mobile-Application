import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/showrooms.dart';

class AdminShowroomItem extends StatelessWidget {
  final String id;
  final String showroomName;
  final String image;

  AdminShowroomItem(this.id, this.showroomName, this.image);

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
                // Navigator.of(context)
                //     .pushNamed(EditProductScreen.routeName, arguments: id);
                Navigator.pushNamed(context, "/manageshowroom", arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  Provider.of<CarShowrooms>(context, listen: false)
                      .deleteShowroom(id);
                } catch (error) {
                  // Scaffold.of(context).showSnackBar(SnackBar(
                  //   content: Text(error.toString()),
                  // ));
                  print(error);
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
