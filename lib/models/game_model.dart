// import 'package:engagefire/mobile.dart';

import 'package:engage_parse_admin/models/developer_model.dart';
import 'package:engage_parse_admin/screens/quick_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:engage_parse_admin/models/category_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

/* TODO: 
  [ ] Add Fields: Modes, Version
*/
class Game extends ParseObject implements ParseCloneable, EngageParseObject {
  Game() : super(_keyTableName);
  Game.clone() : this();

  @override
  clone(Map map) => Game.clone()..fromJson(map);

  static const String _keyTableName = 'Game';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  ParseObject get developer => get<ParseObject>('developer') ?? Developer();
  set developer(ParseObject name) => set<ParseObject>('developer', name);

  String get description => get<String>('description');
  set description(String name) => set<String>('description', name);

  String get primaryColor => get<String>('primaryColor');
  set primaryColor(String name) => set<String>('primaryColor', name);

  String get keywords => get<String>('keywords');
  set keywords(String name) => set<String>('keywords', name);

  double get contentRating => get<double>('contentRating');
  set contentRating(double name) => set<double>('contentRating', name);

  int get quizCount => get<int>('quizCount') ?? 0;
  set quizCount(int name) => set<int>('quizCount', name);

  DateTime get releaseDate => get<DateTime>('releaseDate');
  set releaseDate(DateTime name) => set<DateTime>('releaseDate', name);

  ParseFile get icon => get<ParseFile>('icon');
  set icon(ParseFile name) => set<ParseFile>('icon', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  List<String> get categories =>
      List<String>.from(get<List<String>>('categories', defaultValue: []));
  set categories(List<String> name) => set<List<String>>('categories', name);

  String get source => get<String>('source', defaultValue: 'revealed');
  set source(String name) => set<String>('source', name);

  List<String> get genres =>
      List<String>.from(get<List<String>>('genres', defaultValue: []));
  set genres(List<String> name) => set<List<String>>('genres', name);

  List<String> get platforms =>
      List<String>.from(get<List<String>>('platforms', defaultValue: []));
  set platforms(List<String> name) => set<List<String>>('platforms', name);

  List<String> get characters =>
      List<String>.from(get<List<String>>('characters', defaultValue: []));
  set characters(List<String> name) => set<List<String>>('characters', name);

  List<String> get metaHistory =>
      List<String>.from(get<List<String>>('metaHistory', defaultValue: []));
  set metaHistory(List<String> name) => set<List<String>>('metaHistory', name);

  List<String> get media => //Media
      List<String>.from(get<List<String>>('media', defaultValue: []));
  set media(List<String> name) => set<List<String>>('media', name);

  // Future<List<Quiz>> getQuizzes() async {
  //   QueryBuilder<Quiz> query = QueryBuilder<Quiz>(Quiz())
  //     ..whereEqualTo('game', objectId);
  //   ParseResponse response = await query.query();
  //   if (response.success) {
  //     return (response.results ?? []).cast<Quiz>();
  //   }
  //   return [];
  // }

  // Future<List<Quiz>> getFacts() async {
  //   QueryBuilder<Quiz> query = QueryBuilder<Quiz>(Quiz())
  //     ..whereEqualTo('game', objectId);
  //   ParseResponse response = await query.query();
  //   if (response.success) {
  //     return (response.results ?? []).cast<Quiz>();
  //   }
  //   return [];
  // }

  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Name',
        initialValue: name,
        onChanged: (value) => name = value,
      ),
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Description',
        initialValue: description,
        onChanged: (value) => description = value,
      ),
      QuickAdd(
        labelText: 'Primary Color',
        helperText: 'HEX e.g. 443a49',
        type: 'text',
        initialValue: primaryColor,
        onChanged: (value) => primaryColor = '0xff$value',
      ),
      QuickAdd(
        labelText: 'Released',
        type: 'date',
        initialValue: releaseDate,
        onChanged: (value) => releaseDate = value,
      ),
      QuickAdd(
        labelText: 'Image',
        type: 'image',
        initialValue: image,
        onChanged: (value) => image = ParseFile(value),
      ),
      QuickAdd(
        type: 'smartmulti',
        labelText: 'Categories',
        initialValue: categories,
        collection: GameCategory(),
        onChanged: (value) => categories = value,
      ),
      QuickAdd<Developer>(
        type: 'smartsingle',
        labelText: 'Developer',
        collection: Developer(),
        initialValue: developer.objectId,
        onChanged: (value) async =>
            developer = (await Developer().getObject(value)).result,
        // smartOptions: games.getSmartCategories(),
      )
    ];
  }

  getTabForm() {
    return [
      QuickAddTab.form(name: 'Game', collection: this, children: getForm()),
      QuickAddTab.list(name: 'Developers', collection: Developer()),
    ];
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
