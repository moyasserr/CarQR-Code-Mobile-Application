import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String uid;
  String fireID;
  String firstName;
  String lastName;
  String eMail;
  String userType;

  User({
    @required this.uid,
    this.fireID,
    this.firstName,
    this.lastName,
    this.eMail,
    this.userType,
  });

  Map<String, dynamic> get map {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "eMail": eMail,
      "usertype": userType,
    };
  }

  register() {
    const url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/users.json';
    return http
        .post(url,
            body: json.encode({
              'uid': this.uid,
              'firstname': this.firstName,
              'lastName': this.lastName,
              'eMail': this.eMail,
              'usertype': this.userType,
            }))
        .catchError((error) {
      print(error);
    });
  }

  Future<void> readUser() async {
    final url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.get(url);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, value) {
        if (value['uid'] == this.uid) {
          this.fireID = key;
          this.eMail = value['eMail'];
          this.firstName = value['firstname'];
          this.lastName = value['lastName'];
          this.userType = value['usertype'];
          print("This is ${this.eMail}");
          return this;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
