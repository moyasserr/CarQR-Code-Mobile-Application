import 'package:flutter/cupertino.dart';

class Review {
  double _rating;
  String _comment;
  String _id;
  String _userID;

  Review({String comment, double rating, String id = 'N/A', String userID}) {
    this._comment = comment;
    this._rating = rating;
    this._id = id;
    this._userID = userID;
  }

  set rating(double rating) {
    if (rating >= 0 && rating <= 5) {
      this._rating = rating;
    }
  }

  set comment(String comment) {
    this._comment = comment;
  }

  set id(String id) {
    this._id = id;
  }

  set userID(String userID) {
    this._userID = userID;
  }

  double get rating {
    return this._rating;
  }

  String get comment {
    return this._comment;
  }

  String get id {
    return this._id;
  }

  String get userID {
    return this._userID;
  }
}
