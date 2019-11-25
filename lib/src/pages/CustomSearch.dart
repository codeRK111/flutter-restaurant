import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_rlutter_ui/src/elements/CircularLoadingWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'dart:convert';
import 'package:restaurant_rlutter_ui/src/utils/constant.dart';

class CustomSearch extends StatefulWidget {
  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  List<dynamic> data = [];
  bool loading = false;

  void searchResult(String keyword) async {
    setState(() {
      loading = true;
    });
    String url = baseURL + user + 'searchFood.php';
    var mapBody = {'keyword': keyword};
    print(url);

    try {
      http.Response response = await http.post(url, body: mapBody);
      var res = jsonDecode(response.body);
      print(res.toString());
      setState(() {
        loading = false;
      });
      setState(() {
        data = res['data'];
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
          msg: "Unable to fetch",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: kOrange,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (text) {},
                  onSubmitted: (text) {
                    print(text);
                    searchResult(text);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search for  foods',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(fontSize: 14)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: loading
                  ? CircularLoadingWidget(height: 500)
                  : SearchList(data: data, context: context),
            )
          ],
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({
    Key key,
    @required this.data,
    @required this.context,
  }) : super(key: key);

  final List data;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.0,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: InkWell(
              splashColor: Theme.of(context).accentColor,
              focusColor: Theme.of(context).accentColor,
              highlightColor: Theme.of(context).primaryColor,
              onTap: () {
                Navigator.of(context).pushNamed('/Food',
                    arguments: RouteArgument(
                        id: data[index]["id"],
                        heroTag: 'details_featured_food'));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${data[index]["name"]}'),
                  Text('£ ${data[index]["price"]}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
