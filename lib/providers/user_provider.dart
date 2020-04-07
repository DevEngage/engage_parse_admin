import 'package:engage_parse_admin/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserProvider with ChangeNotifier {
  UserInfo user;
  ParseUser currentUser;
  Profile profile = Profile();
  List<Profile> friends = [];

  UserProvider(this.currentUser) {
    init();
  }

  init() async {
    user = await UserInfo().getUnique();
    profile = await Profile().getUnique();
  }

  getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return user;
  }

  Future<ParseResponse> logout() async {
    if (user == null) {
      await getUser();
    }
    ParseResponse response = await currentUser.logout();
    user = null;
    return response;
  }

  Future<ParseResponse> login(email, password) async {
    ParseResponse response = await ParseUser(email, password, email).login();
    if (response.success) {
      await getUser();
    }
    return response;
  }

  Future<ParseResponse> signUp(email, password) async {
    ParseResponse response = await ParseUser(email, password, email).signUp();
    if (response.success) {
      await getUser();
    }
    return response;
  }

  Future<ParseResponse> anonLogin() async {
    ParseResponse response = await ParseUser(null, null, null).loginAnonymous();
    if (response.success) {
      await getUser();
    }
    return response;
  }

  Future<ParseResponse> requestPasswordReset(email) async {
    ParseResponse response =
        await ParseUser(null, null, email).requestPasswordReset();
    return response;
  }

  convertAnon() {}

  bool get isAnon => isLoggedIn && currentUser.username == null;
  bool get isLoggedIn => user != null;

  getUsers() {
    return ParseUser(null, null, null).getAll();
  }

  getProfile() {}
}
