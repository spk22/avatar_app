import 'package:avatar_back4app/app/home/home_page.dart';
import 'package:avatar_back4app/app/signin/signin_page.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  void initState() {
    final result = ParseAuthService.intiData();
    result.then((bool success) => print(success));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ParseAuthService>(context, listen: false);
    return FutureBuilder<User>(
      future: auth.currentUser(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('user: ${snapshot.data}');
        // return (snapshot.data != null) ? HomePage() : SigninPage();
        final user = snapshot.data;
        if (user != null) {
          return Provider<User>.value(
            value: user,
            child: HomePage(),
          );
        } else {
          return SigninPage();
        }
      },
    );
  }
}
