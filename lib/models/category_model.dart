import 'package:engage_parse_admin/classes/project.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GameCategory extends ParseObject
    implements ParseCloneable, QuickAddParse {
  // List<GameCategory> categories = [];

  GameCategory() : super(_keyTableName);
  GameCategory.clone() : this();

  @override
  clone(Map map) => GameCategory.clone()..fromJson(map);

  static const String _keyTableName = 'Category';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Name',
        initialValue: name,
        onChanged: (value) => name = value,
      ),
    ];
  }

  @override
  List<QuickAddTab> getTabForm() {
    // TODO: implement getTabForm
    return null;
  }

  @override
  List<QuickAddSegment> getSegmentForm() {
    // TODO: implement getSegmentForm
    return null;
  }
}
