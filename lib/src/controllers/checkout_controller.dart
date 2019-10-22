import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/models/credit_card.dart';
import 'package:restaurant_rlutter_ui/src/models/food_order.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/order_status.dart';
import 'package:restaurant_rlutter_ui/src/repository/order_repository.dart' as orderRepo;
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart' as userRepo;

class CheckoutController extends ControllerMVC {
  CreditCard creditCard = new CreditCard();
  bool loading = false;
  GlobalKey<ScaffoldState> scaffoldKey;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }

  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }

  void addOrder(List<Cart> carts, double defaultTax) async {
    setState(() {
      loading = true;
    });
    Order _order = new Order();
    _order.foodOrders = new List<FoodOrder>();
    _order.tax = defaultTax;
    OrderStatus _orderStatus = new OrderStatus();
    _orderStatus.id = '1'; // TODO default order status Id
    _order.orderStatus = _orderStatus;
    carts.forEach((_cart) {
      FoodOrder _foodOrder = new FoodOrder();
      _foodOrder.quantity = _cart.quantity;
      _foodOrder.price = _cart.food.price;
      _foodOrder.food = _cart.food;
      _foodOrder.extras = _cart.extras;
      _order.foodOrders.add(_foodOrder);
    });
    orderRepo.addOrder(_order).then((value) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Your order was added successfully'),
      ));
      setState(() {
        loading = true;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.of(scaffoldKey.currentContext).pushNamed("/Pages", arguments: 3);
      });
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    userRepo.setCreditCard(creditCard).then((value) {
      setState(() {});
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Payment card updated successfully'),
      ));
    });
  }
}
