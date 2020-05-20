import 'package:engage_parse_admin/classes/quick_add_segment_form.dart';
import 'package:engage_parse_admin/models/game_model.dart';
import 'package:engage_parse_admin/models/quiz_model.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

import 'package:engage_parse_admin/classes/engage_parse_object.dart';
import 'package:engage_parse_admin/classes/quick_add.dart';
import 'package:engage_parse_admin/classes/quick_add_segment.dart';
import 'package:engage_parse_admin/classes/quick_add_tab.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:smart_select/smart_select.dart';

class Question extends ParseObject
    implements ParseCloneable, EngageParseObject {
  // List<GameCategory> categories = [];

  Question() : super(_keyTableName);
  Question.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map map) => Question.clone()..fromJson(map);

  static const String _keyTableName = 'Question';
  @override
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  String get description => get<String>('description');
  set description(String name) => set<String>('description', name);

  String get correct => get<String>('correct');
  set correct(String name) => set<String>('correct', name);

  String get difficulty => get<String>('difficulty');
  set difficulty(String name) => set<String>('difficulty', name);

  int get points => get<int>('points');
  set points(int name) => set<int>('points', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  ParseFile get video => get<ParseFile>('video');
  set video(ParseFile name) => set<ParseFile>('video', name);

  String get questionType => get<String>('questionType');
  set questionType(String name) => set<String>('questionType', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  ParseObject get quiz => get<ParseObject>('quiz') ?? Quiz();
  set quiz(ParseObject name) => set<ParseObject>('quiz', name);

  ParseObject get game => get<ParseObject>('game') ?? Game();
  set game(ParseObject name) => set<ParseObject>('game', name);

  List<String> get categories =>
      List<String>.from(get('categories', defaultValue: []));
  set categories(List<String> name) => set<List<String>>('categories', name);

  List<QuestionChoice> get choices => List<QuestionChoice>.from(
      (get('choices') ?? []).map((data) => QuestionChoice.map(data)).toList());

  set choices(List<QuestionChoice> choiceList) =>
      set('choices', choiceList.map((value) => value.toMap()).toList());

  Future saveToArray(field, model) async {
    if (field == 'choices' &&
        model != null &&
        model.correct &&
        model.id != null) {
      correct = model.id;
    }
    List child = get(field);
    if (child == null || child.length == 0) {
      set(field, [model.toMap()]);
      await save();
    } else if (model != null) {
      int index = child.indexWhere((value) => value['id'] == model.id);
      if (index > -1) {
        child[index] = model.toMap();
      } else {
        child.add(model.toMap());
      }
      print(child);
      set(field, child);
      await save();
    }
  }

  Future removeFromArray(field, model) async {
    print(field);
    if (field == 'choices' &&
        model != null &&
        model.correct &&
        model.id != null) {
      correct = null;
    }
    List child = get(field);
    int index = child.indexWhere((value) => value['id'] == model.id);
    if (index > -1) {
      child.removeAt(index);
    }
    set(field, child);
    await save();
  }

  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Name',
        initialValue: name,
        onChanged: (value) => name = value,
      ),
      // QuickAdd(
      //   inputType: TextInputType.multiline,
      //   maxLines: null,
      //   labelText: 'Description',
      //   initialValue: description,
      //   onChanged: (value) => description = value,
      // ),
      QuickAdd(
        type: 'smartsingle',
        maxLines: null,
        labelText: 'Correct Choice',
        initialValue: correct,
        smartOptions: SmartSelectOption.listFrom<String, dynamic>(
            source: choices ?? [],
            value: (val, dynamic game) => game.id,
            title: (val, dynamic game) => game.name),
        onChanged: (value) => correct = value,
      ),
      QuickAdd(
        type: 'smartsingle',
        maxLines: null,
        labelText: 'Difficulty',
        initialValue: difficulty,
        smartOptions: SmartSelectOption.listFrom<String, dynamic>(
            source: ['Easy', 'Medium', 'Hard', 'Master'],
            value: (val, dynamic game) => game.toLowerCase(),
            title: (val, dynamic game) => game),
        onChanged: (value) => difficulty = value,
      ),
      QuickAdd(
        labelText: 'Image',
        type: 'image',
        initialValue: image,
        onChanged: (value) => image = ParseFile(value),
      ),
      // QuickAdd(
      //   labelText: 'Video',
      //   fileType: FileTypeCross.video,
      //   type: 'file',
      //   initialValue: video,
      //   onChanged: (value) => video = ParseFile(value),
      // ),
      // QuickAdd(
      //   labelText: 'Choices',
      //   type: 'list',
      //   initialValue: choices,
      //   listCollection: QuestionChoice(),
      //   onChanged: (value) => choices = value,
      // ),

      // QuickAdd<Game>(
      //   type: 'smartsingle',
      //   labelText: 'Game',
      //   collection: Game(),
      //   initialValue: quiz.objectId,
      //   onChanged: (value) async =>
      //       quiz = (await Quiz().getObject(value)).result,
      //   // smartOptions: games.getSmartCategories(),
      // )
    ];
  }

  getSegmentForm() {
    return [
      QuickAddSegment<QuestionChoice>(
        name: 'Choices',
        index: 1,
        collection: QuestionChoice(),
        list: choices,
        parent: this,
      )
    ];
  }

  getTabForm() {
    return [];
  }
}

class QuestionChoice implements QuickAddSegmentForm {
  String id;
  String name;
  String description;
  ParseFile image;
  ParseFile video;
  bool correct = false;

  QuestionChoice();

  QuestionChoice.map(Map data) {
    id = data['id'] ?? UniqueKey().toString();
    name = data['name'];
    description = data['description'];
    image = data['image'];
    video = data['video'];
    correct = data['correct'] ?? false;
  }

  toMap() {
    return {
      'id': id ?? UniqueKey().toString(),
      'name': name ?? '',
      'description': description ?? '',
      'image': image,
      'video': video,
      'correct': correct ?? false,
    };
  }

  @override
  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Name',
        initialValue: name,
        onChanged: (value) => name = value,
      ),
      // QuickAdd(
      //   inputType: TextInputType.multiline,
      //   maxLines: null,
      //   labelText: 'Description',
      //   initialValue: description,
      //   onChanged: (value) => description = value,
      // ),
      QuickAdd(
        type: 'checkbox',
        maxLines: null,
        labelText: 'Correct',
        initialValue: correct,
        onChanged: (value) => correct = value,
      ),
      // QuickAdd(
      //   labelText: 'Image',
      //   type: 'image',
      //   initialValue: image,
      //   onChanged: (value) => image = ParseFile(value),
      // ),
      // QuickAdd(
      //   labelText: 'Video',
      //   fileType: FileType.VIDEO,
      //   type: 'file',
      //   initialValue: video,
      //   onChanged: (value) => video = ParseFile(value),
      // ),
    ];
  }

  @override
  List<QuickAddTab> getTabForm() {
    // TODO: implement getTabForm
    return null;
  }
}
