import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/models/extra.dart';
import 'package:restaurant_rlutter_ui/src/models/favorite.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/repository/cart_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/food_repository.dart';

class FoodController extends ControllerMVC {
  Food food;
  double quantity = 1;
  double total = 0;
  Favorite favorite;
  bool loadCart = false;
  GlobalKey<ScaffoldState> scaffoldKey;

  FoodController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForFood({String foodId, String message}) async {
    final Stream<Food> stream = await getFood(foodId);
    stream.listen((Food _food) {
      setState(() => food = _food);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {
      calculateTotal();
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForFavorite({String foodId}) async {
    final Stream<Favorite> stream = await isFavoriteFood(foodId);
    stream.listen((Favorite _favorite) {
      setState(() => favorite = _favorite);
    }, onError: (a) {
      print(a);
    });
  }

  void addToCart(Food food) async {
    setState(() {
      this.loadCart = true;
    });
    var _cart = new Cart();
    _cart.food = food;
    _cart.extras = food.extras.where((element) => element.checked).toList();
    _cart.quantity = this.quantity;
    addCart(_cart).then((value) {
      setState(() {
        this.loadCart = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('This food was added to favorite'),
      ));
    });
  }

  void addToFavorite(Food food) async {
    var _favorite = new Favorite();
    _favorite.food = food;
    _favorite.extras = food.extras.where((Extra _extra) {
      return _extra.checked;
    }).toList();
    addFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = value;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('This food was added to favorite'),
      ));
    });
  }

  void removeFromFavorite(Favorite _favorite) async {
    removeFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('This food was removed from favorites'),
      ));
    });
  }

  Future<void> refreshFood() async {
    var _id = food.id;
    food = new Food();
    listenForFavorite(foodId: _id);
    listenForFood(foodId: _id, message: 'Food refreshed successfuly');
  }

  void calculateTotal() {
    total = food.price ?? 0;
    food.extras.forEach((extra) {
      total += extra.checked ? extra.price : 0;
    });
    total *= quantity;
    setState(() {});
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
