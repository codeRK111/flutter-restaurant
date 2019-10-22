import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/controllers/checkout_controller.dart';
import 'package:restaurant_rlutter_ui/src/elements/CreditCardsWidget.dart';
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';

class CheckoutWidget extends StatefulWidget {
  RouteArgument routeArgument;
  CheckoutWidget({Key key, this.routeArgument}) : super(key: key);
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends StateMVC<CheckoutWidget> {
  CheckoutController _con;

  _CheckoutWidgetState() : super(CheckoutController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.payment,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Payment Mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.display1,
                ),
                subtitle: Text(
                  'Select your prefered payment mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            SizedBox(height: 20),
            new CreditCardsWidget(
                creditCard: _con.creditCard,
                onChanged: (creditCard) {
                  _con.updateCreditCard(creditCard);
                }),
            SizedBox(height: 40),
            Text(
              'Or Checkout With',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 320,
              child: FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Image.asset(
                  'assets/img/paypal.png',
                  height: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () {
                      _con.addOrder(
                          widget.routeArgument.param[0] as List<Cart>, widget.routeArgument.param[1] as double);
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Confirm Payment',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                _con.loading
                    ? RefreshProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Helper.getPrice(widget.routeArgument.param[1]),
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .merge(TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
