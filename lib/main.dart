import 'package:avatar_back4app/app/auth_widget.dart';
import 'package:avatar_back4app/app/auth_widget_builder.dart';
import 'package:avatar_back4app/services/parse/image_picker_service.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        home: AuthWidgetBuilder(
          builder: (context, userSnapshot) {
            return AuthWidget(userSnapshot: userSnapshot);
          },
        ),
      ),
    );
  }
}
