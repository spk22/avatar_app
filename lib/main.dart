import 'package:avatar_back4app/app/auth_widget.dart';
import 'package:avatar_back4app/services/parse/image_picker_service.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/home/home_page.dart';
import 'app/routing_constants.dart';
import 'app/signin/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isServerRunning = await ParseAuthService.intiData();
  print(isServerRunning.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ParseAuthService>(
          create: (_) => ParseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
      ],
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
