import 'package:car_qr/Models/review.dart';
import 'package:flutter/material.dart';

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
        subtitle: Text(review.rating.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: Container(
                        width: 300,
                        height: 300,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
