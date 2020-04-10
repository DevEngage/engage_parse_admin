import 'package:engage_parse_admin/classes/project.dart';
import 'package:engage_parse_admin/screens/home_screen.dart';
import 'package:engage_parse_admin/screens/login_screen.dart';
import 'package:engage_parse_admin/screens/quick_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings, ParseUser user,
      EngageProject project, List collections) {
    switch (settings.name) {
      case '/':
        return GetRoute(
          page: user != null
              ? HomeScreen(project: project)
              : LoginScreen(project: project),
          settings: settings,
        );
      case '/Login':
        return GetRoute(
          page: LoginScreen(project: project),
          settings: settings,
        );
      case '/Home':
        return GetRoute(
          page: HomeScreen(project: project, collections: collections),
          settings: settings,
        );
      case '/QuickAdd':
        return GetRoute(
          page: QuickAddScreen(
            addRoute: '/QuickAdd',
            project: project,
          ),
          settings: settings,
        );
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
