import 'package:flutter/material.dart';

class BookSeat extends StatefulWidget {
  @override
  _BookSeatState createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CustomCard(),
              SizedBox(
                height: 25,
              ),
              CustomCard(),
              SizedBox(
                height: 25,
              ),
              CustomCard(),
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
  const CustomCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Colors.white,
          child: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
