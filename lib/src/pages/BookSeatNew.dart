import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookSeatNew extends StatefulWidget {
  final RouteArgument routeArgument;
  BookSeatNew({Key key, this.routeArgument}) : super(key: key);
  @override
  _BookSeatNewState createState() => _BookSeatNewState();
}

class _BookSeatNewState extends State<BookSeatNew> {
  String dropdownValue = '1';
  String date = "";
  String time = "";
  String id;

  bool isDateEmpty = false;
  bool isTimeEmpty = false;

  String dateLabel = "Select date";
  String timeLabel = "Select time";
  List<String> seats = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];

  @override
  void initState() {
    // TODO: implement initState

    id = widget.routeArgument.id;
    super.initState();
  }

  Future<Map<String, dynamic>> bookSeat() async {
    var mapBody = {
      'restaurant_id': widget.routeArgument.id,
      'user_id': '1',
      'date': date,
      'time': time,
      'seats': dropdownValue
    };
    String url = "http://ladmin.ibnus.io/api/v1/user/bookTable.php";
    http.Response response = await http.post(url, body: mapBody);
    var res = jsonDecode(response.body);
    print(mapBody.toString());
    print(res.toString());
    return {'status': res['status']};
  }

  void book() async {
    if (date.length == 0 || time.length == 0) {
      setState(() {
        if (date.length == 0) {
          isDateEmpty = true;
          dateLabel = "Please enter a date ";
        } else {
          isDateEmpty = false;
          dateLabel = "Select date";
        }
        if (time.length == 0) {
          isTimeEmpty = true;
          timeLabel = "Please enter time";
        } else {
          isTimeEmpty = false;
          timeLabel = "Select time";
        }
      });
      return;
    }

    var apiResult = await bookSeat();
    if (apiResult['status'] == 'success') {
      setState(() {
        isDateEmpty = false;
        isTimeEmpty = false;
        dateLabel = "Select date";
        timeLabel = "Select time";
      });

      Navigator.of(context).pushNamed('/TicketList',
          arguments: RouteArgument(
            id: id,
            heroTag: 'home_restaurants',
          ));
    }

//    Alert(
//        context: context,
//        closeFunction: () {
//          Navigator.of(context).pushNamed('/Details',
//              arguments: RouteArgument(
//                id: "2",
//                heroTag: 'home_restaurants',
//              ));
//        },
//        title: "Table confirmed",
//        desc: "Congratulation your table is confirmed",
//        image: Image.asset("assets/img/success.png"),
//        buttons: []).show();
  }

  void getDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 12, 31), onChanged: (date) {
      print('change $date');
    }, onConfirm: (d) {
      print('confirm $d');
      setState(() {
        date = d.day.toString() +
            "-" +
            d.month.toString() +
            "-" +
            d.year.toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void getTime() {
    DatePicker.showTimePicker(context, onChanged: (t) {}, onConfirm: (t) {
      setState(() {
        time = t.hour.toString() +
            ":" +
            t.minute.toString() +
            ":" +
            t.second.toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Widget dropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Select seat"),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.deepOrange[400], width: 4.0),
            ),
          ),
          child: Material(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 0.0,
                  color: Colors.deepOrange[400],
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: seats.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          // The containers in the background
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[400],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        "Book a table",
                        style: kHeader,
                      )
                    ],
                  )),
              new Container(
                height: MediaQuery.of(context).size.height * .5,
                color: Colors.white,
              )
            ],
          ),
          // The card widget with top padding,
          // in case if you wanted bottom padding to work,
          // set the `alignment` of container to Alignment.bottomCenter
          new Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .2,
                right: 30.0,
                left: 30.0),
            child: new Container(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: new Material(
                  color: Colors.white,
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: <Widget>[
                        new InputField(
                          icon: Icons.calendar_today,
                          label: dateLabel,
                          placeholder: date,
                          onTap: getDate,
                          isEmpty: isDateEmpty,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        new InputField(
                          icon: Icons.watch_later,
                          label: timeLabel,
                          placeholder: time,
                          onTap: getTime,
                          isEmpty: isTimeEmpty,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        dropdown(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        GestureDetector(
                          onTap: () {
                            book();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height * .3,
                            height: MediaQuery.of(context).size.height * .08,
                            color: Colors.deepOrange[400],
                            child: Center(
                              child: Text(
                                "Book",
                                style: kInnerButtonTextStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class InputField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final String label;
  final Function onTap;
  final bool isEmpty;
  InputField(
      {this.icon, this.placeholder, this.label, this.onTap, this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: isEmpty ? kError : kDefault,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .08,
            width: MediaQuery.of(context).size.height * .3,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.deepOrange[400], width: 4.0),
              ),
            ),
            child: Material(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(placeholder), Icon(icon)],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
