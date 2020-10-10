import 'package:avatar_back4app/common_widgets/avatar.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  final User user;
  AboutPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Advanced Provider',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 32.0),
            Text(
              'Online YouTube Course',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 32.0),
            Text(
              'codingwithflutter.com',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    // set the uploaded image into user Avatar
    // final user = Provider.of<User>(context, listen: false);
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
          // onPressed: () => _chooseAvatar(context, user),
        );
      },
    );
  }
}
