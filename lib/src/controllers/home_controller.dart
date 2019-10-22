import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/category.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/models/review.dart';
import 'package:restaurant_rlutter_ui/src/repository/category_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/food_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/restaurant_repository.dart';

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  List<Restaurant> topRestaurants = <Restaurant>[];
  List<Review> recentReviews = <Review>[];
  List<Food> trendingFoods = <Food>[];

  HomeController() {
    listenForCategories();
    listenForTopRestaurants();
    listenForRecentReviews();
    listenForTrendingFoods();
  }

  void listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForTopRestaurants() async {
    final Stream<Restaurant> stream = await getTopRestaurants();
    stream.listen((Restaurant _restaurant) {
      setState(() => topRestaurants.add(_restaurant));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForRecentReviews() async {
    final Stream<Review> stream = await getRecentReviews();
    stream.listen((Review _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForTrendingFoods() async {
    final Stream<Food> stream = await getTrendingFoods();
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshHome() async {
    categories = <Category>[];
    topRestaurants = <Restaurant>[];
    recentReviews = <Review>[];
    trendingFoods = <Food>[];
    listenForCategories();
    listenForTopRestaurants();
    listenForRecentReviews();
    listenForTrendingFoods();
  }
}
