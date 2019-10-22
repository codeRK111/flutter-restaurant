import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/pages/cart.dart';
import 'package:restaurant_rlutter_ui/src/pages/category.dart';
import 'package:restaurant_rlutter_ui/src/pages/checkout.dart';
import 'package:restaurant_rlutter_ui/src/pages/debug.dart';
import 'package:restaurant_rlutter_ui/src/pages/details.dart';
import 'package:restaurant_rlutter_ui/src/pages/food.dart';
import 'package:restaurant_rlutter_ui/src/pages/help.dart';
import 'package:restaurant_rlutter_ui/src/pages/languages.dart';
import 'package:restaurant_rlutter_ui/src/pages/login.dart';
import 'package:restaurant_rlutter_ui/src/pages/map.dart';
import 'package:restaurant_rlutter_ui/src/pages/menu_list.dart';
import 'package:restaurant_rlutter_ui/src/pages/mobile_verification.dart';
import 'package:restaurant_rlutter_ui/src/pages/mobile_verification_2.dart';
import 'package:restaurant_rlutter_ui/src/pages/pages.dart';
import 'package:restaurant_rlutter_ui/src/pages/settings.dart';
import 'package:restaurant_rlutter_ui/src/pages/signup.dart';
import 'package:restaurant_rlutter_ui/src/pages/walkthrough.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Debug':
        return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case '/':
        return MaterialPageRoute(builder: (_) => Walkthrough());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => MobileVerification());
      case '/MobileVerification2':
        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: args));
      case '/Details':
        return MaterialPageRoute(builder: (_) => DetailsWidget(routeArgument: args as RouteArgument));
      case '/Map':
        return MaterialPageRoute(builder: (_) => MapWidget());
      case '/Menu':
        return MaterialPageRoute(builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      case '/Food':
        return MaterialPageRoute(builder: (_) => FoodWidget(routeArgument: args as RouteArgument));
      case '/Category':
        return MaterialPageRoute(builder: (_) => CategoryWidget(routeArgument: args as RouteArgument));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget(routeArgument: args as RouteArgument));
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: 2));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
