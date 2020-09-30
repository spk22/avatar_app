import 'package:avatar_back4app/app/auth_widget.dart';
import 'package:avatar_back4app/app/home/home_page.dart';
import 'package:avatar_back4app/app/routing_constants.dart';
import 'package:avatar_back4app/app/signin/signin_page.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ParseAuthService>(
      create: (_) => ParseAuthService(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWidget(),
        routes: {
          RoutingConstants.homePage: (context) => HomePage(),
          RoutingConstants.signinPage: (context) => SigninPage(),
        },
      ),
    );
  }
}
