import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Screens/popmenupages.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget titlex;
  final Function history;
  final Function showrooms;
  final Function settings;
  final Function about;
  MyAppBar(
      {Key key,
      @required this.titlex,
      @required this.history,
      @required this.showrooms,
      @required this.settings,
      @required this.about,
      List actions})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Container(
      //   margin: const EdgeInsets.only(left: 10.0),
      //   width: 20,
      //   height: 20,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     border: Border.all(width: 2, color: Color.fromRGBO(32, 150, 243, 1)),
      //     image: DecorationImage(
      //         image: AssetImage('assets/images/logo.jpg'), fit: BoxFit.fill),
      //   ),
      // ),
      title: widget.titlex,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: choiceaction,
          itemBuilder: (BuildContext context) {
            return Sidemenu.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void choiceaction(String choice) {
    if (choice == Sidemenu.history) {
      widget.history();
    } else if (choice == Sidemenu.showrooms) {
      widget.showrooms();
    } else if (choice == Sidemenu.settings) {
      widget.settings();
    } else if (choice == Sidemenu.about) {
      widget.about();
    }
  }
}
