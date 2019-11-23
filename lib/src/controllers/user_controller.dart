import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/models/user.dart';
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart'
    as repository;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:restaurant_rlutter_ui/src/utils/constant.dart';

class UserController extends ControllerMVC {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  User user = new User();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool _loading = true;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  bool get loading => _loading;

  void setFCMToken(userid, deviceid, callback) async {
    var mapBody = {'user_id': userid, 'fcm_token': deviceid};
    String url = "${baseURL}user/setFCMToken.php";
    print(mapBody.toString());
//    http.Response response = await http.post(url, body: mapBody);
//    var res = jsonDecode(response.body);
//    print(mapBody.toString());
//    print(res.toString());
//    callback();
    try {
      http.Response response = await http.post(url, body: mapBody);
      var res = jsonDecode(response.body);
      print(mapBody.toString());
      print(res.toString());

      callback();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("error $e");
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: "Unable to fetch",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: kOrange,
          textColor: Colors.white,
          fontSize: 16.0);
      callback();
    }
  }

  void goToDetailsPage(context) {
    Navigator.of(context).pushNamed('/Details',
        arguments: RouteArgument(
          id: "2",
          heroTag: 'home_restaurants',
        ));
  }

  void login(context) async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.login(user).then((value) {
        //print(value.apiToken);
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Welcome ${value.name}!'),
          ));
          _firebaseMessaging.getToken().then((token) {
            setFCMToken(value.id, token, () {
              goToDetailsPage(context);
            });
          });
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Wrong email or password'),
          ));
        }
      });
    }
  }

  void register() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Welcome ${value.name}!'),
          ));
          Navigator.of(scaffoldKey.currentContext)
              .pushNamed('/Pages', arguments: 2);
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Wrong email or password'),
          ));
        }
      });
    }
  }
}
