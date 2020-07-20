import 'package:flutter/material.dart';
import '../widgets/keyboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, body: body);
  }

  Widget get appBar => AppBar(
        title: const Text('Live Calculator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
          ),
          // action button
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {},
          ),
        ],
      );

  Widget get body => Column(
        children: <Widget>[
          Expanded(child: calculatorScreen),
          Expanded(flex: 2, child: calculatorKeyboard)
        ],
      );

  Widget get calculatorScreen => Container(color: Colors.black);

  Widget get calculatorKeyboard => Keyboard(columnCount: 4, buttons: <Widget>[
        Expanded(child: OutlineButton(child: Text('Hello'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(child: OutlineButton(child: Text('Helloi'))),
        Expanded(flex: 2, child: OutlineButton(child: Text('Helloi2')))
      ]);
}
