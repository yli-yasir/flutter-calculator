import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/calculator_theme.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: calculatorThemeData,
      home: HomeScreen(),
    );
  }
}
