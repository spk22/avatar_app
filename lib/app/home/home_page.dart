import 'package:avatar_back4app/common_widgets/avatar.dart';
import 'package:avatar_back4app/services/parse/image_picker_service.dart';
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
      final user = Provider.of<User>(context, listen: false);
      final isLoggedOut = await auth.signOut(user);
      if (isLoggedOut) {
        Navigator.of(context).pop();
      } else {
        print('ERROR: user not available');
      }
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => AuthWidget()),
      // );
    } catch (e) {
      print(e);
    }
  }

  Widget _buildUserInfo(BuildContext context) {
    // set the uploaded image into user Avatar
    final user = Provider.of<User>(context, listen: false);
    final auth = Provider.of<ParseAuthService>(context, listen: false);
    return FutureBuilder<bool>(
      future: auth.hasImage(user),
      // initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Avatar(
          hasImage: snapshot.data ?? false,
          user: user,
          radius: 50.0,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context, user),
        );
      },
    );
    // return Avatar(
    //   hasImage: false,
    //   user: user,
    //   radius: 50.0,
    //   borderColor: Colors.black54,
    //   borderWidth: 2.0,
    //   onPressed: () => _chooseAvatar(context, user),
    // );
  }

  Future<void> _chooseAvatar(BuildContext context, User user) async {
    try {
      // 1. Get image from picker
      // 2. Upload to storage
      // 3. Save url to backend
      // 4. (optional) delete local file as no longer needed
      final picker = Provider.of<ImagePickerService>(context, listen: false);
      final isUploaded = await picker.uploadParseImage(context, user);
      print('upload response: $isUploaded');
    } catch (e) {
      print(e);
    }
  }
}
