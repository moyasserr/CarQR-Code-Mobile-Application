import 'package:car_qr/Models/review.dart';
import 'package:car_qr/Widgets/car_review_list_each.dart';
import 'package:flutter/material.dart';

class CarReviewList extends StatelessWidget {
  final List<Review> reviews;

  CarReviewList({@required this.reviews});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChilderenCarReviews(),
    );
  }

  List<Widget> getChilderenCarReviews() {
    return reviews.map((care) => CarReviewListEach(review: care)).toList();
  }
}
