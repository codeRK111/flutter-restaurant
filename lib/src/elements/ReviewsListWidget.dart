import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ReviewItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/review.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatelessWidget {
  List<Review> reviewsList;

  ReviewsListWidget({Key key, this.reviewsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviewsList.isEmpty
        ? CircularLoadingWidget(height: 200)
        : ListView.separated(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ReviewItemWidget(review: reviewsList.elementAt(index));
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: reviewsList.length,
            primary: false,
            shrinkWrap: true,
          );
  }
}
