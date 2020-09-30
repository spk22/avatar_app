import 'package:avatar_back4app/app/auth_widget.dart';
import 'package:avatar_back4app/app/routing_constants.dart';
import 'package:avatar_back4app/services/parse/parse_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        color: Colors.white,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.teal),
                    hintText: 'eg: test@gmail.com',
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                  validator: (value) =>
                      value.isEmpty ? 'You must enter a valid email' : null,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) => value.length <= 4
                      ? 'Your password must be larger than 4 characters'
                      : null,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.teal,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _signIn(context);
                    }
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    //TODO: Implement
    try {
      final auth = Provider.of<ParseAuthService>(context, listen: false);
      User user = await auth.signIn(_email, _password);
      if (user != null) {
        print('Object Id: ' + user.uid);
        // Navigator.of(context).pushReplacementNamed(RoutingConstants.homePage);
        // Navigator.pushNamed(context, RoutingConstants.homePage);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthWidget()),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
