import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/repository/restaurant_repository.dart';

class MapController extends ControllerMVC {
  List<Restaurant> topRestaurants = <Restaurant>[];
  List<Marker> allMarkers = <Marker>[];

  MapController() {
    listenForTopRestaurants();
  }

  void listenForTopRestaurants() async {
    final Stream<Restaurant> stream = await getTopRestaurants();
    stream.listen((Restaurant _restaurant) {
      setState(() {
        topRestaurants.add(_restaurant);
      });
      Helper.getMarker(_restaurant.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  Future refreshMap() async {
    topRestaurants = <Restaurant>[];
    listenForTopRestaurants();
  }
}
