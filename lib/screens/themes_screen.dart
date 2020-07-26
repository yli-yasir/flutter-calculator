import 'package:flutter/material.dart';
import 'package:flutter_calculator/provider/theme_model.dart';
import 'package:flutter_calculator/themes/calculator_blue_theme.dart';
import 'package:flutter_calculator/themes/calculator_purple_theme.dart';

class ThemesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Themes')), body: ThemeScreenBody());
  }
}

class ThemeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildThemeList(context);
  }

  Widget _buildThemeList(context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: themeItems.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final itemIndex = i ~/ 2;
          return _buildThemeListTile(context, themeItems[itemIndex]);
        });
  }

  Widget _buildThemeListTile(context, ThemeItem item) {
    return ListTile(
        title: Text(item.title),
        trailing: Icon(
            ThemeModel.of(context).currentTheme == item.theme
                ? Icons.check_circle
                : Icons.check_circle_outline,
            color: Theme.of(context).accentColor),
        onTap: () {
          print('tapped');
          ThemeModel.of(context).currentTheme = item.theme;
        });
  }
}

class ThemeItem {
  final String title;
  final ThemeData theme;
  ThemeItem({this.title, this.theme});
}

List<ThemeItem> themeItems = [
  ThemeItem(title: 'Purple', theme: calculatorPurpleTheme),
  ThemeItem(title: 'Blue', theme: calculatorBlueTheme)
];
