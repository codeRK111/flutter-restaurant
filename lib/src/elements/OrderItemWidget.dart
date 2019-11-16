import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:restaurant_rlutter_ui/src/controllers/food_controller.dart';
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/food_order.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OrderItemWidget extends StatefulWidget {
  final String heroTag;
  final FoodOrder foodOrder;
  final Order order;

  OrderItemWidget({Key key, this.foodOrder, this.order, this.heroTag})
      : super(key: key);

  @override
  _OrderItemWidgetState createState() {
    return _OrderItemWidgetState();
  }
}

class _OrderItemWidgetState extends StateMVC<OrderItemWidget> {
  FoodController _con;

  _OrderItemWidgetState() : super(FoodController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: widget.heroTag + widget.foodOrder.id,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(widget.foodOrder.food.image.thumb),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.foodOrder.food.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Text(
                        widget.foodOrder.food.restaurant.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        Helper.getTotalOrderPrice(
                            widget.foodOrder, widget.order.tax),
                        style: Theme.of(context).textTheme.display1),
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(widget.foodOrder.dateTime),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      DateFormat('HH:mm').format(widget.foodOrder.dateTime),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  splashColor: Theme.of(context).accentColor,
                  focusColor: Theme.of(context).accentColor,
                  highlightColor: Theme.of(context).primaryColor,
                  onTap: () {
                    print(widget.foodOrder.food.name);

//                    _con.incrementQuantity();
                    _con.addToCartTest(widget.foodOrder.food, context);
// TODO go to tracking page
//        Navigator.of(context).pushNamed('/Food', arguments: RouteArgument(id: order.foods[0].id, heroTag: this.heroTag));
                  },
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: kOrange,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
