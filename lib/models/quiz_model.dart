import 'package:engage_parse_admin/classes/quick_add_parse.dart';
import 'package:engage_parse_admin/models/game_model.dart';
import 'package:engage_parse_admin/models/question_model.dart';
import 'package:flutter/material.dart';

import 'package:engage_parse_admin/classes/engage_parse_object.dart';
import 'package:engage_parse_admin/classes/quick_add.dart';
import 'package:engage_parse_admin/classes/quick_add_segment.dart';
import 'package:engage_parse_admin/classes/quick_add_tab.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:smart_select/smart_select.dart';

class Quiz extends ParseObject implements ParseCloneable, EngageParseObject {
  Quiz() : super(_keyTableName);
  Quiz.clone() : this();

  @override
  clone(Map map) => Quiz.clone()..fromJson(map);

  static const String _keyTableName = 'Quiz';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  String get description => get<String>('description');
  set description(String name) => set<String>('description', name);

  int get points => get<int>('points');
  set points(int name) => set<int>('points', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  ParseFile get video => get<ParseFile>('video');
  set video(ParseFile name) => set<ParseFile>('video', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  ParseObject get game => get<ParseObject>('game') ?? Game();
  set game(ParseObject name) => set<ParseObject>('game', name);

  double get cost => get<double>('cost') ?? 0.00;
  set cost(double name) => set<double>('cost', name);

  double get rating => get<double>('rating') ?? 0.0;
  set rating(double name) => set<double>('rating', name);

  String get status => get<String>('status') ?? 'preparing';
  set status(String name) => set<String>('status', name);

  // DateTime get releaseDate => get<DateTime>('releaseDate');
  // set releaseDate(DateTime name) => set<DateTime>('releaseDate', name);

  List<String> get categories =>
      List<String>.from(get('categories', defaultValue: []));
  set categories(List<String> name) => set<List<String>>('categories', name);

  List<String> get modes =>
      List<String>.from(get<List<String>>('modes', defaultValue: []));
  set modes(List<String> name) => set<List<String>>('modes', name);

  // List<String> get questions => // Question
  //     List<String>.from(get<List<String>>('questions', defaultValue: []));
  // set questions(List<String> name) => set<List<String>>('questions', name);
  List<Question> questions = [];
  Map<String, List<Question>> questionsByDifficulty = {
    'easy': [],
    'medium': [],
    'hard': [],
    'master': [],
  };

  getQuestions([difficulty]) async {
    QueryBuilder<Question> query = QueryBuilder<Question>(Question());
    query.whereEqualTo('quiz', this);
    if (difficulty != null) query.whereEqualTo('difficulty', difficulty);
    ParseResponse res = await query.query();
    if (res.success && res.results != null) {
      questions = List<Question>.from(res.results ?? []);
    }
    groupQuestions();
  }

  groupQuestions() {
    questionsByDifficulty['easy'] = questions
        .where((element) =>
            element != null && (element.difficulty ?? '') == 'easy')
        .toList();
    questionsByDifficulty['medium'] = questions
        .where((element) =>
            element != null && (element.difficulty ?? '') == 'medium')
        .toList();
    questionsByDifficulty['hard'] = questions
        .where((element) =>
            element != null && (element.difficulty ?? '') == 'hard')
        .toList();
    questionsByDifficulty['master'] = questions
        .where((element) =>
            element != null && (element.difficulty ?? '') == 'master')
        .toList();
  }

  getQuestionsCount([difficulty]) {
    if (difficulty == null) return (questions ?? []).length;
    if (questionsByDifficulty != null &&
        questionsByDifficulty[difficulty] != null)
      return (questionsByDifficulty[difficulty] ?? []).length;
    return 0;
  }

  getForm() {
    return [
      // QuickAdd(
      //   type: 'smartsingle',
      //   labelText: 'Game',
      //   initialValue: game.objectId,
      //   collection: Game(),
      //   onChanged: (value) async =>
      //       game = (await Game().getObject(value)).result,
      // ),
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
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'Points',
        initialValue: points,
        onChanged: (value) => points = value,
      ),
      QuickAdd(
        type: 'smartsingle',
        maxLines: null,
        labelText: 'Status',
        initialValue: status,
        smartOptions: SmartSelectOption.listFrom<String, dynamic>(
            source: ['preparing', 'active', 'inactive', 'backlog'],
            value: (val, dynamic name) => name,
            title: (val, dynamic name) => name),
        onChanged: (value) => status = value,
      ),
      QuickAdd(
        labelText: 'Image',
        type: 'image',
        initialValue: image,
        onChanged: (value) => image = ParseFile(value),
      ),
      // QuickAdd(
      //   type: 'smartmulti',
      //   labelText: 'Categories',
      //   initialValue: categories,
      //   collection: GameCategory(),
      //   onChanged: (value) => categories = value,
      // ),
    ];
  }

  getTabForm() {
    return [
      QuickAddTab.form(name: 'Game', collection: this, children: getForm()),
      QuickAddTab.list(name: 'Questions', collection: Question(), parent: this),
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

class QuizMode extends ParseObject
    implements ParseCloneable, EngageParseObject {
  QuizMode() : super(_keyTableName);
  QuizMode.clone() : this();

  @override
  clone(Map map) => QuizMode.clone()..fromJson(map);

  static const String _keyTableName = 'QuizMode';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get name => get<String>('name');
  set name(String name) => set<String>('name', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  getForm() {
    return [];
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

class UserQuiz extends ParseObject implements ParseCloneable, QuickAddParse {
  Map tmpAnswers = {};
  UserQuiz() : super(_keyTableName);
  UserQuiz.clone() : this();

  @override
  clone(Map map) => UserQuiz.clone()..fromJson(map);

  static const String _keyTableName = 'UserQuiz';
  String get tableName => _keyTableName;

  bool get finished => get<bool>('finished') ?? false;
  set finished(bool name) => set<bool>('finished', name);

  Quiz get quiz => get<ParseObject>('quiz') != null
      ? Quiz().clone(get<ParseObject>('quiz').toJson())
      : null;
  set quiz(Quiz name) => set<Quiz>('quiz', name);

  // ParseObject get game => get<ParseObject>('game') ?? Game();
  // set game(ParseObject name) => set<ParseObject>('game', name);

  int get highScore => get<int>('highScore') ?? 0;
  set highScore(int name) => set<int>('highScore', name);

  Map get difficultyScores =>
      Map.from(get<Map>('difficultyScores', defaultValue: {}));
  set difficultyScores(Map name) => set<Map>('difficultyScores', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  Map get answers => Map.from(get<Map>('answers', defaultValue: {}));
  set answers(Map name) => set<Map>('answers', name);

  Future<UserQuiz> getOwned(quiz, [ParseUser user]) async {
    user ??= await ParseUser.currentUser();
    QueryBuilder<UserQuiz> query = QueryBuilder<UserQuiz>(UserQuiz());
    query.whereEqualTo('owner', user);
    query.whereEqualTo('quiz', quiz);
    query.setLimit(1);
    ParseResponse res = await query.query();
    if (res.success && res.results != null) {
      return res.results[0] ?? UserQuiz();
    } else {
      ParseResponse res = await (UserQuiz()
            ..owner = user
            ..quiz = quiz)
          .save();
      return res.result ?? UserQuiz()
        ..owner = user
        ..quiz = quiz;
    }
  }

  setHighscore([int score = 0, String difficulty]) {
    if (difficulty == null &&
        difficultyScores['random'] != null &&
        difficultyScores['random'] < score) {
      difficultyScores['random'] = score;
    } else if (difficulty != null &&
        difficultyScores[(difficulty ?? '').toLowerCase()] != null &&
        difficultyScores[(difficulty ?? '').toLowerCase()] < score) {
      difficultyScores[(difficulty ?? '').toLowerCase()] = score;
    }
    if (score > highScore) {
      highScore = difficultyScores.entries.fold(
          0, (previousValue, element) => previousValue + (element.value ?? 0));
    }
  }

  saveAnswers() async {
    ParseUser user = await ParseUser.currentUser();
    if (user == null) return;
    Map answered = answers ?? {};
    tmpAnswers.forEach((key, val) {
      if (val != null &&
          (answers[key] == null || answers[key]['correct'] == false)) {
        answered[key] = val.toMap();
      }
    });
    answers = answered;
    owner = user;
    await save();
  }

  getUnanswered(List list) {
    var answeredList = answers.entries;
    if (answeredList.isEmpty) return list;
    return list.where((question) {
      var re = answeredList.any((answer) =>
          question.objectId == answer.value['questionId'] &&
          answer.value['correct']);
      return !re;
    }).toList();
  }

  bool addAnswer(Question question, [QuestionChoice answer]) {
    if (answer == null) {
      tmpAnswers[question.objectId] = null;
      return false;
    }
    tmpAnswers[question.objectId] = UserAnswer(
      questionId: question.objectId,
      name: question.name,
      difficulty: question.difficulty,
      choiceId: answer.id,
      choiceName: answer.name,
      correct: question.correct == answer.id,
    );
    return question.correct == answer.id;
  }

  List getCorrectAnswers() {
    return tmpAnswers.entries
        .where((element) =>
            element != null &&
            element?.value != null &&
            element?.value?.correct == true)
        .toList();
  }

  List getAnsweredCorrectly([String difficulty]) {
    print(answers);
    return answers.entries
        .where((element) =>
            element != null &&
            ((difficulty != null &&
                    element.value['difficulty'] == difficulty) ||
                difficulty == null) &&
            element?.value != null &&
            element?.value['correct'] == true)
        .toList();
  }

  List getWrongAnswers() {
    return tmpAnswers.entries
        .where((element) =>
            element == null ||
            element?.value == null ||
            element?.value?.correct == false)
        .toList();
  }

  getForm() {
    return [
      QuickAdd(
        inputType: TextInputType.multiline,
        maxLines: null,
        labelText: 'quiz',
        collection: Quiz(),
        initialValue: quiz.objectId,
        onChanged: (value) async =>
            quiz = (await Quiz().getObject(value)).result,
      ),
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
}

class UserAnswer {
  String questionId;
  String choiceId;
  String name;
  String choiceName;
  String difficulty;
  bool correct;

  UserAnswer({
    this.questionId,
    this.choiceId,
    this.name,
    this.choiceName,
    this.difficulty,
    this.correct,
  });

  toMap() {
    return {
      'questionId': questionId,
      'name': name,
      'choiceId': choiceId,
      'choiceName': choiceName,
      'difficulty': difficulty,
      'correct': correct,
    };
  }
}
