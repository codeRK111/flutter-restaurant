import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/credit_card.dart';
import 'package:restaurant_rlutter_ui/src/models/user.dart';
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  User user = new User();
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void update(User user) async {
    repository.update(user).then((value) {
      setState(() {
        //this.favorite = value;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Profile settings updated successfully'),
      ));
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    repository.setCreditCard(creditCard).then((value) {
      setState(() {});
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Payment settings updated successfully'),
      ));
    });
  }

  void listenForUser() async {
    user = await repository.getCurrentUser();
    creditCard = await repository.getCreditCard();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    user = new User();
    creditCard = new CreditCard();
    listenForUser();
  }
}
