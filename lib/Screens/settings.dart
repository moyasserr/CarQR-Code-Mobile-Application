import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_qr/Models/user.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';
  final User user;
  Settings({@required this.user});
  @override
  _SettingsState createState() => _SettingsState(user: user);
}

class _SettingsState extends State<Settings> {
  bool _dark;
  var _isLoading = false;
  final User user;

  _SettingsState({@required this.user});

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // theme: ThemeData(
      //   brightness: _getBrightness(),
      // ),

      backgroundColor: _dark ? null : Colors.grey.shade200,
      appBar: AppBar(
        title: new Text(
          'App Settings',
          style: TextStyle(fontSize: 22.0),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.blue,
                        child: ListTile(
                          onTap: () {
                            //open edit profile
                          },
                          title: Text(
                            "${user.firstName} ${user.lastName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/images/messi.jpg'),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Card(
                        elevation: 4.0,
                        margin:
                            const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.lock_outline,
                                color: Colors.blue,
                              ),
                              title: Text("Change Password"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            _buildDivider(),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.language,
                                color: Colors.blue,
                              ),
                              title: Text("Change Language"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change language
                              },
                            ),
                            _buildDivider(),
                            // ListTile(
                            //     leading: Icon(
                            //       Icons.exit_to_app,
                            //       color: Colors.blue,
                            //     ),
                            //     title: Text("Logout"),
                            //     trailing: Icon(Icons.keyboard_arrow_right),
                            //     onTap: () {})
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Advanced Settings",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: Colors.blue,
                        contentPadding: const EdgeInsets.all(0),
                        value: true,
                        title: Text("Notifications"),
                        onChanged: (val) {},
                      ),
                      SwitchListTile(
                        activeColor: Colors.blue,
                        contentPadding: const EdgeInsets.all(0),
                        value: false,
                        title: Text("Dark Mode"),
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 60.0),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
