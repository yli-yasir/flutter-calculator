import 'package:flutter/material.dart';
import 'package:flutter_calculator/provider/theme_model.dart';
import 'package:flutter_calculator/screens/about_screen.dart';
import 'package:flutter_calculator/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeModel(), child: App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, themeModel, child) {
      return MaterialApp(
        title: 'gbCalculator',
        theme: themeModel.currentTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/themes': (context) => ThemesScreen(),
          '/about': (context) => AboutScreen()
        },
      );
    });
  }
}
