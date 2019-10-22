import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/src/controllers/walkthrough_controller.dart';
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

class Walkthrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: new WalkthroughWidget(),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.of(context).pushNamed('/Pages', arguments: 2);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Skip',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).pushNamed('/Login');
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).accentColor,
                ),
              ],
            )),
      ],
    );
  }
}

class WalkthroughWidget extends StatefulWidget {
  WalkthroughWidget({
    Key key,
  }) : super(key: key);

  @override
  _WalkthroughWidgetState createState() => _WalkthroughWidgetState();
}

class _WalkthroughWidgetState extends StateMVC<WalkthroughWidget> {
  WalkthroughController _con;

  _WalkthroughWidgetState() : super(WalkthroughController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _ac = config.App(context);
    return _con.topRestaurants.isEmpty
        ? CircularLoadingWidget(height: _ac.appHeight(100))
        : Container(
            height: _ac.appHeight(100),
            child: Swiper(
              itemCount: 3,
              pagination: SwiperPagination(
                margin: EdgeInsets.only(bottom: _ac.appHeight(10)),
                builder: DotSwiperPaginationBuilder(
                  activeColor: Theme.of(context).accentColor,
                  color: Theme.of(context).accentColor.withOpacity(0.2),
                ),
              ),
              itemBuilder: (context, index) {
                return new WalkthroughItemWidget(_con.topRestaurants.elementAt(index));
              },
            ),
          );
  }
}

class WalkthroughItemWidget extends StatelessWidget {
  Restaurant restaurant;

  WalkthroughItemWidget(this.restaurant, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ac = config.App(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 140,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  )
                ]),
            margin: EdgeInsets.symmetric(
              horizontal: _ac.appHorizontalPadding(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: _ac.appWidth(80),
            height: _ac.appHeight(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 150),
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Theme.of(context).focusColor.withOpacity(1),
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        restaurant.address,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  restaurant.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.body2,
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(restaurant.image.thumb),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                )
              ]),
          margin: EdgeInsets.symmetric(
            horizontal: _ac.appHorizontalPadding(16),
            vertical: _ac.appVerticalPadding(10),
          ),
          width: _ac.appWidth(100),
          height: 220,
        ),
      ],
    );
  }
}
