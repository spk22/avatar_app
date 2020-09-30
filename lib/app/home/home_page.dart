import 'package:avatar_back4app/app/auth_widget.dart';
import 'package:avatar_back4app/app/routing_constants.dart';
import 'package:avatar_back4app/common_widgets/avatar.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => _onAbout(context),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _signout(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          child: Column(
            children: <Widget>[
              _buildUserInfo(context),
              SizedBox(height: 16.0),
            ],
          ),
          preferredSize: Size.fromHeight(130.0),
        ),
      ),
    );
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AboutPage(),
      fullscreenDialog: true,
    ));
  }

  Future<void> _signout(BuildContext context) async {
    try {
      final auth = Provider.of<ParseAuthService>(context, listen: false);
      await auth.signOut();
      // Navigator.of(context).pushReplacementNamed(RoutingConstants.signinPage);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthWidget()),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _buildUserInfo(BuildContext context) {
    //TODO: Download and show avatar from backend
    return Avatar(
      photoUrl: null,
      radius: 50.0,
      borderColor: Colors.black54,
      borderWidth: 2.0,
      onPressed: () => _chooseAvatar(context),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      // 2. Upload to storage
      // 3. Save url to backend
      // 4. (optional) delete local file as no longer needed
    } catch (e) {
      print(e);
    }
  }
}
