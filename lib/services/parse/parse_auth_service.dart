import 'package:avatar_back4app/services/parse/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@immutable
class User {
  final String uid;
  const User({@required this.uid});
}

class ParseAuthService {
  // this method returns true if Parse Server is intialized & running healthy
  static Future<bool> intiData() async {
    await Parse().initialize(
      AppKeys.APP_ID,
      AppKeys.APP_SERVER_URL,
      clientKey: AppKeys.APP_CLIENT_KEY,
      autoSendSessionId: true,
      debug: true,
      // coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    );
    final ParseResponse parseResponse = await Parse().healthCheck();
    return parseResponse.success;
  }

  User _userFromParse(ParseUser user) {
    return user == null ? null : User(uid: user.objectId);
  }

  Future<User> currentUser() async {
    ParseUser currentUser = await ParseUser.currentUser();
    return _userFromParse(currentUser);
  }

  Future<User> signIn(String userName, String password) async {
    final user = ParseUser(userName, password, userName);
    final response = await user.login();
    if (response.success) {
      // ParseUser currentUser = await ParseUser.currentUser();
      // bool isSame = (user.objectId == currentUser.objectId);
      // print('Is currentUser same as logined user: ' + isSame.toString());
      // print(currentUser.toString());
      return _userFromParse(user);
    } else
      return null;
  }

  Stream<ParseUser> _onAuthStateChanged() async* {
    while (true) {
      ParseUser currentUser = await ParseUser.currentUser();
      yield currentUser;
    }
  }

  Stream<User> get onAuthStateChanged {
    return _onAuthStateChanged().map((parseUser) => _userFromParse(parseUser));
  }

  Future<void> signOut() async {
    ParseUser currentUser = await ParseUser.currentUser();
    currentUser.logout();
  }
}
