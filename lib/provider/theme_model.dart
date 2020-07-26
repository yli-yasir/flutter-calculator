import 'package:flutter/material.dart';
import 'package:flutter_calculator/themes/calculator_purple_theme.dart';
import 'package:provider/provider.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = calculatorPurpleTheme;

  get currentTheme => _currentTheme;
  set currentTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  static ThemeModel of(BuildContext context) =>
      Provider.of<ThemeModel>(context, listen: false);
}
