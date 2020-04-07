import 'package:flutter/material.dart';
import 'package:get/get.dart';

routes(BuildContext context) {
  List sections = [];
  return <Widget>[
    // for (var section in sections)
    //   FlatButton(
    //     child: Text(
    //       section.tableName,
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     onPressed: () => Get.to(
    //       QuickList(
    //         collection: section,
    //         addRoute: '/QuickAdd',
    //         appBar: AppBar(
    //           title: Text(section.tableName),
    //         ),
    //         onTap: (item) => Get.toNamed(
    //           '/QuickAdd',
    //           arguments: {'collection': item},
    //         ),
    //       ),
    //     ),
    //   ),
    // VerticalDivider(),
    FlatButton(
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => null,
    )
  ];
}
