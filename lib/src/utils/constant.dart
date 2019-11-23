import 'package:flutter/material.dart';

const kOrange = Colors.deepOrange;

const kBookSeatLabelStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);

const kInnerButtonTextStyle = TextStyle(fontSize: 16.0, color: Colors.white);
const kHeader =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 30.0);

const kError = TextStyle(color: Colors.red);

const kDefault = TextStyle(color: Colors.black);
const kTicketNumber =
    TextStyle(color: kOrange, fontSize: 20.0, fontWeight: FontWeight.w600);
const kRestroName = TextStyle(
  color: Colors.black,
  fontSize: 15.0,
  fontWeight: FontWeight.w700,
);

const kRestroDetails = TextStyle(
  color: Colors.black,
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
);

const kRestroKey = TextStyle(
  fontSize: 15.0,
);

const kBookingInfo = TextStyle(fontWeight: FontWeight.w600);

const baseURL = 'https://laravel.ouronlineserver.com/api/v1/';
const user = 'user/';
const admin = 'admin/';

enum status { pending, approved, rejected }
