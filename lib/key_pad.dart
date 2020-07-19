import 'package:flutter/material.dart';

class KeyPad extends StatefulWidget {
  @override
  KeyPadState createState() => KeyPadState();
}

final buttons = <Widget>[
  Flexible(
      flex: 1, fit: FlexFit.tight, child: OutlineButton(child: Text('Hello'))),
  Flexible(
      flex: 1, fit: FlexFit.tight, child: OutlineButton(child: Text('Hello')))
];

class KeyPadState extends State<KeyPad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons)),
        Flexible(
            fit: FlexFit.tight,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons)),
      ],
    );
  }
}
