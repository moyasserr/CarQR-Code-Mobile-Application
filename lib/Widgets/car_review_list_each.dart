import 'package:car_qr/Models/review.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';

class CarReviewListEach extends StatelessWidget {
  final Review review;
  final int state;

  CarReviewListEach({@required this.review, this.state = 0});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('Test'),
        title: Text(review.comment.toString()),
        subtitle: GFRating(
          color: Colors.yellow,
          value: review.rating,
        ),
      ),
    );
  }
}
