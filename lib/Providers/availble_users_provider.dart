import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:car_qr/Models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  final String url =
      "https://carqr-e4c82-default-rtdb.firebaseio.com/users.json";
  List<User> _users = [];

  UnmodifiableListView<User> get users {
    return UnmodifiableListView(_users);
  }

  addUser(User user) {
    const url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/users.json';
    return http
        .post(url,
            body: json.encode({
              'firstName': user.firstName,
              'lastName': user.lastName,
              'email': user.eMail,
              'username': user.username,
              'password': user.password,
            }))
        .then((res) {
      final newUser = User(
        firstName: user.firstName,
        lastName: user.lastName,
        eMail: user.eMail,
        username: user.username,
        password: user.password,
      );
      _users.add(newUser);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }
}
