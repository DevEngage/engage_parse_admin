import 'package:engage_parse_admin/screens/home_screen.dart';
import 'package:engage_parse_admin/screens/login_screen.dart';
import 'package:engage_parse_admin/screens/quick_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings, ParseUser user) {
    switch (settings.name) {
      case '/':
        return GetRoute(
          page: user != null ? HomeScreen() : LoginScreen(),
          settings: settings,
        );
      case '/Login':
        return GetRoute(
          page: LoginScreen(),
          settings: settings,
        );
      case '/Home':
        return GetRoute(
          page: HomeScreen(),
          settings: settings,
        );
      case '/QuickAdd':
        return GetRoute(
          page: QuickAddScreen(addRoute: '/QuickAdd'),
          settings: settings,
        );
      // case '/Home':
      //   return GetRoute(settings: settings, builder: (_) => Home());
      // case '/Chat':
      //   return GetRoute(settings: settings, builder: (_) => Chat());
      default:
        return GetRoute(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
