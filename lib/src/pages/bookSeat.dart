import 'dart:convert';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';

class BookSeat extends StatefulWidget {
  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  String date = "17th december";
  String time = "7";
  var seats = ["1", "2", "3"];
  String seat = "1";

  void getDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
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

  void getseat() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var alertSeat = seat;
          Function test = setState;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Book seat"),
                      DropdownButton(
                        value: alertSeat,
                        onChanged: (String v) {
                          setState(() {
                            alertSeat = v;
                          });
                          test(() {
                            seat = v;
                          });
                          print(seat);
                        },
                        items: seats.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          color: Colors.deepOrange[400],
                          child: Center(child: Text("Confirm $seat seats")),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[50]),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              CustomCard(
                  icon: Icons.calendar_today, text: date, getDate: getDate),
              SizedBox(
                height: 25,
              ),
              CustomCard(
                icon: Icons.watch_later,
                text: time,
                getDate: getTime,
              ),
              SizedBox(
                height: 25,
              ),
              CustomCard(
                icon: Icons.supervised_user_circle,
                text: "$seat seats",
                getDate: getseat,
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Material(
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.deepOrange[400],
                    textColor: Colors.white,
                    child: Text("Book"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function getDate;

  const CustomCard({this.icon, this.text, this.getDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: () {
          getDate();
        },
        child: Container(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: 90.0,
                        color: Colors.deepOrange[400],
                      ),
                      Text(
                        text,
                        style: kBookSeatLabelStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
