import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/review.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Screens/car_description.dart';

class Ucarreview extends StatefulWidget {
  final User loggedUser;
  final Car car;
  final int reviewInd;

  Ucarreview(
      {@required this.loggedUser,
      @required this.car,
      @required this.reviewInd});
  @override
  State<StatefulWidget> createState() {
    return UcarreviewState(
        loggedUser: loggedUser, car: car, reviewInd: reviewInd);
  }
}

class UcarreviewState extends State<Ucarreview> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = new TextEditingController();
  double _rating = 1;
  String comment = "";
  double count = 1;
  final User loggedUser;
  final Car car;
  final int reviewInd;

  UcarreviewState(
      {@required this.loggedUser,
      @required this.car,
      @required this.reviewInd});

  get rating => _rating;

  bool _isReviewd = false;
  String reviewType = "Add";

  void submitReview() {
    if (reviewInd == -1) {
      Provider.of<AvailableCarsModel>(context, listen: false)
          .addReview(loggedUser.fireID, this.comment, this.rating, car.id);
    } else {
      String revID = car.reviews[reviewInd].id;
      Review newReview = Review(
        userID: loggedUser.fireID,
        id: revID,
        comment: comment,
        rating: rating,
      );
      Provider.of<AvailableCarsModel>(context, listen: false).editReview(
        id: revID,
        carID: car.id,
        newReview: newReview,
      );
    }

    Navigator.pop(context);
    Navigator.pop(context);
  }

  void deleteRev() {
    Provider.of<AvailableCarsModel>(context, listen: false)
        .deleteReview(car.id, car.reviews[reviewInd].id);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (reviewInd != -1) {
      _isReviewd = true;
      reviewType = "Edit";
      textController.text = car.reviews[reviewInd].comment;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Review")),
      body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: _formKey,
            child: new ListView(
              children: <Widget>[
                new Text(
                  '$reviewType Review',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new Text(
                  'Rating',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                GFRating(
                  color: Colors.yellow,
                  value: _rating,
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                ),
                new Text(
                  'Comment',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                new TextFormField(
                  controller: textController,
                  style: TextStyle(height: 3.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        width: 3,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: 'write your comment',
                  ),
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter Comment";
                    else {
                      comment = val;
                      return null;
                    }
                  },
                ),
                new RaisedButton(
                  child: new Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      submitReview();
                    }
                  },
                  color: Colors.blue,
                  highlightColor: Colors.blueGrey,
                ),
                RaisedButton(
                  child: new Text("Delete"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Widget cancelButton = FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        Widget continueButton = FlatButton(
                          child: Text("Continue"),
                          onPressed: () {
                            deleteRev();
                            Navigator.of(context).pop();
                          },
                        );

                        AlertDialog alert = AlertDialog(
                          title: Text("AlertDialog"),
                          content: Text(
                              "Are you sure you want to delete your review"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );
                        return alert;
                      },
                    );
                  },
                  color: Colors.red,
                  highlightColor: Colors.blueGrey,
                ),
              ],
            ),
          )),
    );
  }
}
