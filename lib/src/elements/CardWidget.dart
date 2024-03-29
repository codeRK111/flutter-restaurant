import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

class CardWidget extends StatelessWidget {
  Restaurant restaurant;
  String heroTag;

  CardWidget({Key key, this.restaurant, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Image of the card
          Hero(
            tag: this.heroTag + restaurant.id,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(restaurant.image.url),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Text(
                        Helper.skipHtml(restaurant.description),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: Helper.getStarsList(double.parse(restaurant.rate)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      print('Go to map');
                      Navigator.of(context).pushNamed('/Map', arguments: restaurant.id);
                    },
                    child: Icon(Icons.directions, color: Theme.of(context).primaryColor),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
