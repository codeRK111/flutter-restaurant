import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/repository/restaurant_repository.dart';

class WalkthroughController extends ControllerMVC {
  List<Restaurant> topRestaurants = <Restaurant>[];

  WalkthroughController() {
    listenForTopRestaurants();
  }
  void listenForTopRestaurants() async {
    final Stream<Restaurant> stream = await getTopRestaurants();
    stream.listen((Restaurant _restaurant) {
      setState(() => topRestaurants.add(_restaurant));
    }, onError: (a) {}, onDone: () {});
  }
}
