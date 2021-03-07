import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/review.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Widgets/car_review_list.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Screens/user_car_review.dart';
import 'package:provider/provider.dart';

class CarReviews extends StatefulWidget {
  final Car car;
  final User loggedUser;

  CarReviews({@required this.car, @required this.loggedUser});
  @override
  _CarReviewsState createState() =>
      _CarReviewsState(car: car, loggedUser: loggedUser);
}

class _CarReviewsState extends State<CarReviews> {
  final Car car;
  final User loggedUser;
  int reviewInd = -1;

  bool _isReviewed = false;

  _CarReviewsState({@required this.car, @required this.loggedUser});

  @override
  void initState() {
    // TODO: implement initState
    String value = loggedUser.fireID;
    final reviewIndex =
        car.reviews.indexWhere((review) => review.userID == value);
    if (reviewIndex != -1) {
      _isReviewed = true;
      reviewInd = reviewIndex;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars List'),
      ),
      body: Container(
        child: CarReviewList(
          reviews: car.reviews,
        ),
      ),
      floatingActionButton: _isReviewed
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ucarreview(
                      loggedUser: loggedUser,
                      car: car,
                      reviewInd: reviewInd,
                    ),
                  ),
                );
              },
              child: Icon(Icons.edit),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ucarreview(
                            loggedUser: loggedUser,
                            car: car,
                            reviewInd: reviewInd,
                          )),
                );
              },
              child: Icon(Icons.add),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
