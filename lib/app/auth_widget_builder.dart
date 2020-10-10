import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;
  const AuthWidgetBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBuilder build');
    final auth = Provider.of<ParseAuthService>(context, listen: false);
    return FutureBuilder<User>(
      future: auth.currentUser(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        print('FutureBuilder: ${snapshot.data}');
        // return (snapshot.data != null) ? HomePage() : SigninPage();
        final user = snapshot.data;
        if (user != null) {
          return Provider<User>.value(
            value: user,
            child: builder(context, snapshot),
          );
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}
