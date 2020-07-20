import 'package:flutter/material.dart';
import 'keyboard.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final buttons = <Widget>[
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Hello'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(fit: FlexFit.tight, child: OutlineButton(child: Text('Helloi'))),
    Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: OutlineButton(child: Text('Helloi2')))
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
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
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(color: Colors.black)),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Keyboard(columnCount: 4, buttons: buttons))
              ],
            )));
  }
}
