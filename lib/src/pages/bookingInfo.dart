import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/controllers/restaurant_controller.dart';
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingDetails extends StatefulWidget {
  final RouteArgument routeArgument;
  BookingDetails({Key key, this.routeArgument}) : super(key: key);
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends StateMVC<BookingDetails> {
  Map<String, dynamic> bookingInfo;
  RestaurantController _con;

  _BookingDetailsState() : super(RestaurantController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForRestaurant(id: widget.routeArgument.id);
    _con.listenForGalleries(widget.routeArgument.id);
    _con.listenForRestaurantReviews(id: widget.routeArgument.id);
    _con.listenForFeaturedFoods(widget.routeArgument.id);
    bookingInfo = widget.routeArgument.param;
    super.initState();
  }

  Map<String, dynamic> statusColor(String s) {
    if (s == 'approved') {
      return {'color': Colors.green, 'status': 'approved'};
    } else if (s == 'pending') {
      return {'color': Colors.yellow, 'status': 'pending'};
    } else {
      return {'color': Colors.red, 'status': 'rejected'};
    }
  }

  showModal() {
    Alert(
        context: context,
        closeFunction: () {
          Navigator.of(context).pushNamed('/Details',
              arguments: RouteArgument(
                id: "2",
                heroTag: 'home_restaurants',
              ));
        },
        title: "Successful",
        desc: "Your booking has been cancelled",
        image: Image.asset("assets/img/success.png"),
        buttons: []).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: _con.restaurant == null
              ? CircularLoadingWidget(height: 500)
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leading: Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(Icons.arrow_back),
                              tooltip: 'Add new entry',
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight: 300,
                          elevation: 0,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: widget.routeArgument.heroTag + '2',
                              child: Image.network(
                                _con.restaurant.image.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Wrap(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        bookingInfo['ticketnumber'],
                                        style: kTicketNumber,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        bookingInfo['restroname'],
                                        style: kRestroName,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "status",
                                          style: kRestroKey,
                                        ),
                                        Text(
                                          statusColor(
                                              bookingInfo['status'])['status'],
                                          style: TextStyle(
                                            color: statusColor(
                                                bookingInfo['status'])['color'],
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Date",
                                          style: kRestroKey,
                                        ),
                                        Text(
                                          bookingInfo['date'],
                                          style: kRestroDetails,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Time",
                                          style: kRestroKey,
                                        ),
                                        Text(
                                          bookingInfo['time'],
                                          style: kRestroDetails,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Seats",
                                          style: kRestroKey,
                                        ),
                                        Text(
                                          bookingInfo['seats'],
                                          style: kRestroDetails,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
