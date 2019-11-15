import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TableList extends StatefulWidget {
  final RouteArgument routeArgument;
  TableList({Key key, this.routeArgument}) : super(key: key);
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  String id;
  bool loading = false;
  List<dynamic> bookingList = [];

  final List<int> colorCodes = <int>[600, 500, 100];

  Map<String, dynamic> statusColor(String s) {
    if (s == 'approved') {
      return {'color': Colors.green, 'status': 'approved'};
    } else if (s == 'pending') {
      return {'color': Colors.yellow, 'status': 'pending'};
    } else {
      return {'color': Colors.red, 'status': 'rejected'};
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    id = widget.routeArgument.id;
    getBookings();

    super.initState();
  }

  Future<Map<String, dynamic>> getBookingsFromAPI() async {
    String url = baseURL + user + 'getBookingList.php?user_id=1';

    http.Response response = await http.get(url);
    var res = jsonDecode(response.body);

    return {'data': res['data']};
  }

  void getBookings() async {
    setState(() {
      loading = true;
    });
    var result = await getBookingsFromAPI();
    print(result['data'].toString());
    setState(() {
      loading = false;
      bookingList = result['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Booking list",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange[400],
        ),
        body: loading
            ? CircularLoadingWidget(height: 500)
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: bookingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new BookingCard(
                    bookInfo: bookingList[index],
                    statusColor: statusColor(bookingList[index]['status']),
                  );
                }),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> bookInfo;
  final Map<String, dynamic> statusColor;
  const BookingCard({this.bookInfo, this.statusColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(bookInfo.toString());
        Navigator.of(context).pushNamed('/BookingDetailsPage',
            arguments: RouteArgument(
                id: bookInfo['restaurantid'],
                heroTag: 'home_restaurants',
                param: bookInfo));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(5.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          bookInfo['ticketnumber'],
                          style: kTicketNumber,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                bookInfo['restroname'],
                                style: kRestroName,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Date"),
                        Text(
                          bookInfo['date'],
                          style: kBookingInfo,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Time"),
                        Text(
                          bookInfo['time'],
                          style: kBookingInfo,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Seats"),
                        Text(
                          bookInfo['seats'],
                          style: kBookingInfo,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Status"),
                        Text(
                          statusColor['status'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: statusColor['color']),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
