import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/models/user.dart';
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart'
    as repository;

class UserController extends ControllerMVC {
  User user = new User();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
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
          Navigator.of(context).pushNamed('/Details',
              arguments: RouteArgument(
                id: "2",
                heroTag: 'home_restaurants',
              ));
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
