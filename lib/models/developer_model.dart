import 'package:engage_parse_admin/screens/quick_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Developer extends ParseObject
    implements ParseCloneable, EngageParseObject {
  // List<GameCategory> categories = [];

  Developer() : super(_keyTableName);
  Developer.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map map) => Developer.clone()..fromJson(map);

  static const String _keyTableName = 'Developer';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  String get description => get<String>('description');
  set description(String name) => set<String>('description', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  DateTime get foundedAt => get<DateTime>('foundedAt');
  set foundedAt(DateTime name) => set<DateTime>('foundedAt', name);

  List<String> get categories =>
      List<String>.from(get<List<String>>('categories', defaultValue: []));
  set categories(List<String> name) => set<List<String>>('categories', name);

  List<String> get games =>
      List<String>.from(get<List<String>>('games', defaultValue: []));
  set games(List<String> name) => set<List<String>>('games', name);

  List<String> get publishers =>
      List<String>.from(get<List<String>>('publishers', defaultValue: []));
  set publishers(List<String> name) => set<List<String>>('publishers', name);

  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Name',
        initialValue: name,
        onChanged: (value) => name = value,
      )
    ];
  }

  getTabForm() {
    return [];
  }

  @override
  List<QuickAddSegment> getSegmentForm() {
    // TODO: implement getSegmentForm
    return null;
  }

  @override
  saveToArray(field, model) {
    // TODO: implement saveToArray
    return null;
  }

  @override
  removeFromArray(field, model) {
    // TODO: implement removeFromArray
    return null;
  }
}
