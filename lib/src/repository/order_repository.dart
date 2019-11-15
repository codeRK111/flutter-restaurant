import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/credit_card.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/user.dart';
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart';

Future<Stream<Order>> getOrders() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders?${_apiToken}with=user;foodOrders;foodOrders.food;orderStatus&search=user.id:${_user.id}&searchFields=user.id:=&orderBy=id&sortedBy=desc';
  print(url);

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Order.fromJSON(data);
  });
}

Future<Stream<Order>> getRecentOrders() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders?${_apiToken}with=user;foodOrders;foodOrders.food;orderStatus&search=user.id:${_user.id}&searchFields=user.id:=&orderBy=updated_at&sortedBy=desc&limit=3';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Order.fromJSON(data);
  });
}

Future<Order> addOrder(Order order) async {
  User _user = await getCurrentUser();
  CreditCard _creditCard = await getCreditCard();
  order.user = _user;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders?$_apiToken';
  final client = new http.Client();
  Map params = order.toMap();
  params.addAll(_creditCard.toMap());
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(params),
  );
  return Order.fromJSON(json.decode(response.body)['data']);
}
