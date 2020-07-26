import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About')),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Column(children: <Widget>[
              Text('gbCalculator',
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 16),
              Text(
                  'This is a demo calculator app which supports basic calculations.'),
              SizedBox(height: 16),
              Text(
                  "The app is made with Flutter and written in the Dart programming language."),
              SizedBox(height: 16),
              Text(
                  "For any inquiries please contact the developer at yli.devs@gmail.com")
            ])));
  }
}
