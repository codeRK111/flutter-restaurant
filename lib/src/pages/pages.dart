import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/DrawerWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/pages/favorites.dart';
import 'package:restaurant_rlutter_ui/src/pages/home.dart';
import 'package:restaurant_rlutter_ui/src/pages/notifications.dart';
import 'package:restaurant_rlutter_ui/src/pages/orders.dart';
import 'package:restaurant_rlutter_ui/src/pages/profile.dart';
import 'package:restaurant_rlutter_ui/src/repository/user_repository.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  int currentTab;
  String currentTitle = 'Home';
  Widget currentPage = HomeWidget();

  PagesTestWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = currentTab != null ? currentTab : 2;
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  initState() {
    super.initState();
    getCurrentUser().then((user) {
      if (user.apiToken == null) {
        Navigator.of(context).pushNamed('/Login');
      }
    }).whenComplete(() {
      _selectTab(widget.currentTab);
    });
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Notifications';
          widget.currentPage = NotificationsWidget();
          break;
        case 1:
          widget.currentTitle = 'Profile';
          widget.currentPage = ProfileWidget();
          break;
        case 2:
          widget.currentTitle = 'Home';
          Navigator.of(context).pushNamed('/Details',
              arguments: RouteArgument(
                id: "2",
                heroTag: 'home_restaurants',
              ));
          //  widget.currentPage = HomeWidget();
          break;
        case 3:
          widget.currentTitle = 'My Orders';
          widget.currentPage = OrdersWidget();
          break;
        case 4:
          widget.currentTitle = 'Favorites';
          widget.currentPage = FavoritesWidget();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.currentTitle,
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
        currentIndex: widget.currentTab,
        onTap: (int i) {
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child:
                    new Icon(Icons.home, color: Theme.of(context).primaryColor),
              )),
          BottomNavigationBarItem(
            icon: new Icon(Icons.fastfood),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
