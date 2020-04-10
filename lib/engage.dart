import 'package:engage_parse_admin/classes/project.dart';
import 'package:engage_parse_admin/providers/user_provider.dart';
import 'package:engage_parse_admin/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Engage {
  static init({
    ParseUser user,
    EngageProject project,
    Function onRouter,
    List collections,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(user)),
      ],
      child: MaterialApp(
        onGenerateRoute: (RouteSettings settings) => onRouter != null
            ? onRouter(settings, user, project, collections)
            : Router.generateRoute(settings, user, project, collections),
        initialRoute: "/",
        navigatorKey: Get.key,
        title: project.name,
        theme: project.theme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
