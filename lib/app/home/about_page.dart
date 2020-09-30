import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
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
}
