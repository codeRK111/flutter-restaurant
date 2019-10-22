import 'package:restaurant_rlutter_ui/src/models/media.dart';

class Restaurant {
  String id;
  String name;
  Media image;
  String rate;
  String address;
  String description;
  String phone;
  String mobile;
  String information;
  String latitude;
  String longitude;

  Restaurant();

  Restaurant.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'].toString(),
        name = jsonMap['name'],
        image = jsonMap['media'] != null ? Media.fromJSON(jsonMap['media'][0]) : null,
        rate = jsonMap['rate'] ?? '0',
        address = jsonMap['address'],
        description = jsonMap['description'],
        phone = jsonMap['phone'],
        mobile = jsonMap['mobile'],
        information = jsonMap['information'],
        latitude = jsonMap['latitude'],
        longitude = jsonMap['longitude'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
