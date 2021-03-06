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
      masterKey: AppKeys.APP_MASTER_KEY,
      autoSendSessionId: false,
      debug: false,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    );
    final ParseResponse parseResponse = await Parse().healthCheck();
    return parseResponse.success;
  }

  Future<ParseUser> getParseUser(User user) async {
    final response = await ParseUser.forQuery().getObject(user.uid);
    ParseUser parseUser = (response.success) ? response.results.first : null;
    return parseUser;
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

  Future<bool> signOut(User user) async {
    ParseUser parseUser = await getParseUser(user);
    ParseResponse response = await parseUser.logout();
    return response.success;
  }

  Future<bool> hasImage(User user) async {
    ParseUser parseUser = await getParseUser(user);
    var result = parseUser.get<ParseFileBase>("image");
    print('hasImage: ' + (result != null).toString());
    return (result != null);
  }
}
