import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/models/setting.dart';
import 'package:restaurant_rlutter_ui/src/repository/cart_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/settings_repository.dart';

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  Setting setting = new Setting();
  double taxAmount = 0.0;
  double subTotal = 0.0;
  double total = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey;

  CartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCarts();
    listenForSettings();
  }

  void listenForCarts({String message}) async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      if (!carts.contains(_cart)) {
        setState(() {
          carts.add(_cart);
        });
      }
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {
      calculateSubtotal();
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForSettings() async {
    final Stream<Setting> stream = await getSettings();
    stream.listen((Setting _setting) {
      setState(() => setting = _setting);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {
      calculateSubtotal();
    });
  }

  Future<void> refreshCarts() async {
    listenForCarts(message: 'Carts refreshed successfuly');
  }

  void removeFromCart(Cart _cart) async {
    setState(() {
      this.carts.remove(_cart);
    });
    removeCart(_cart).then((value) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("The ${_cart.food.name} was removed from your cart"),
      ));
    });
  }

  void calculateSubtotal() {
    subTotal = 0;
    carts.forEach((cart) {
      subTotal += cart.quantity * cart.food.price;
    });
    taxAmount = subTotal * setting.defaultTax / 100;
    total = subTotal + taxAmount;
    setState(() {});
  }

  incrementQuantity(Cart cart) {
    if (cart.quantity <= 99) {
      ++cart.quantity;
      calculateSubtotal();
    }
  }

  decrementQuantity(Cart cart) {
    if (cart.quantity > 1) {
      --cart.quantity;
      calculateSubtotal();
    }
  }
}
