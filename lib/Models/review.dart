import 'package:flutter/cupertino.dart';

class Review {
  double _rating;
  String comment;

  Review({this.comment});

  set rating(double rating) {
    if (rating >= 0 && rating <= 5) {
      this._rating = rating;
    }
  }

  double get rating {
    return this._rating;
  }
}
