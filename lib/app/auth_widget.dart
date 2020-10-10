import 'package:avatar_back4app/app/home/home_page.dart';
import 'package:avatar_back4app/app/signin/signin_page.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<User> userSnapshot;
  const AuthWidget({Key key, this.userSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.hasData) {
      print('User: ${userSnapshot.data}');
      return HomePage();
    } else {
      return SigninPage();
    }
  }
}
