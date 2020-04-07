import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserInfo extends ParseObject implements ParseCloneable {
  UserInfo() : super(_keyTableName);
  UserInfo.clone() : this();

  @override
  clone(Map map) => UserInfo.clone()..fromJson(map);

  static const String _keyTableName = 'UserInfo';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  num get weight => get<num>('weight') ?? 0.0;
  set weight(num name) => set<num>('weight', name);

  String get weightType => get<String>('weightType') ?? 'lb';
  set weightType(String name) => set<String>('weightType', name);

  String get gender => get<String>('gender', defaultValue: 'Male') ?? 'Male';
  set gender(String name) => set<String>('gender', name);

  String get height => get<String>('height') ?? '5\'10"';
  set height(String name) => set<String>('height', name);

  String get heightType => get<String>('heightType') ?? 'feet';
  set heightType(String name) => set<String>('heightType', name);

  int get birthYear => get<int>('birthYear') ?? 1990;
  set birthYear(int name) => set<int>('birthYear', name);

  num get caloriesGoal => get<num>('caloriesGoal') ?? 2000;
  set caloriesGoal(num name) => set<num>('caloriesGoal', name);

  num get carbsGoal => get<num>('carbsGoal') ?? 0.0;
  set carbsGoal(num name) => set<num>('carbsGoal', name);

  num get proteinGoal => get<num>('proteinGoal') ?? 0.0;
  set proteinGoal(num name) => set<num>('proteinGoal', name);

  num get fatGoal => get<num>('fatGoal') ?? 0.0;
  set fatGoal(num name) => set<num>('fatGoal', name);

  num get fiberGoal => get<num>('fiberGoal') ?? 0.0;
  set fiberGoal(num name) => set<num>('fiberGoal', name);

  String get macroGoalType => get<String>('macroGoalType');
  set macroGoalType(String name) => set<String>('macroGoalType', name);

  num get weightGoal => get<num>('weightGoal') ?? 180;
  set weightGoal(num name) => set<num>('weightGoal', name);

  String get weightGoalType => get<String>('weightGoalType') ?? 'lb';
  set weightGoalType(String name) => set<String>('weightGoalType', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  num get exerciseTimeGoal =>
      get<num>('exerciseTimeGoal') ?? 0.0; // minutes a day
  set exerciseTimeGoal(num name) => set<num>('exerciseTimeGoal', name);

  num get bmi => get<num>('bmi') ?? 0.0; // minutes a day
  set bmi(num name) => set<num>('bmi', name);

  num get bodyFatPercentage =>
      get<num>('bodyFatPercentage') ?? 0.0; // minutes a day
  set bodyFatPercentage(num name) => set<num>('bodyFatPercentage', name);

  Future<UserInfo> getUnique([ParseUser user]) async {
    user ??= await ParseUser.currentUser();
    QueryBuilder<UserInfo> query = QueryBuilder<UserInfo>(UserInfo());
    query.whereEqualTo('owner', user);
    query.setLimit(1);
    ParseResponse res = await query.query();
    if (res.success && res.results != null) {
      return res.results[0] ?? UserInfo();
    } else {
      ParseResponse res = await (UserInfo()..owner = user).save();
      return res.result ?? UserInfo()
        ..owner = user;
    }
  }
}

class Profile extends ParseObject implements ParseCloneable {
  Profile() : super(_keyTableName);
  Profile.clone() : this();

  @override
  clone(Map map) => Profile.clone()..fromJson(map);

  static const String _keyTableName = 'Profile';
  String get tableName => _keyTableName;

  String get objectId => get<String>('objectId');
  set objectId(String name) => set<String>('objectId', name);

  String get firstName => get<String>('firstName') ?? '';
  set firstName(String name) => set<String>('firstName', name);

  String get lastName => get<String>('lastName') ?? '';
  set lastName(String name) => set<String>('lastName', name);

  String get email => get<String>('email') ?? '';
  set email(String name) => set<String>('email', name);

  ParseUser get owner => get<ParseUser>('owner');
  set owner(ParseUser name) => set<ParseUser>('owner', name);

  ParseFile get image => get<ParseFile>('image');
  set image(ParseFile name) => set<ParseFile>('image', name);

  Future<Profile> getUnique([ParseUser user]) async {
    user ??= await ParseUser.currentUser();
    QueryBuilder<Profile> query = QueryBuilder<Profile>(Profile());
    query.whereEqualTo('owner', user);
    query.setLimit(1);
    ParseResponse res = await query.query();
    if (res.success && res.results != null) {
      return res.results[0] ?? Profile();
    } else {
      ParseResponse res = await (Profile()..owner = user).save();
      return res.result ?? Profile()
        ..owner = user;
    }
  }

  String get fullName => '$firstName $lastName';
}
