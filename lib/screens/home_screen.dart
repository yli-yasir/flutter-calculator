import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/general_widgets/keyboard.dart';
import 'package:flutter_calculator/provider/calculator_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomeScreenAppBar(), body: HomeScreenBody());
  }
}

// Consider splitting into smaller files.

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => AppBar(
        title: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Theme.of(context).primaryColor,
            child: Text('gbCalculator')),
        actions: <Widget>[
          PopupMenuButton<MenuOption>(
              onSelected: (MenuOption option) => option.onTap(context),
              itemBuilder: (context) => menuOptions
                  .map((MenuOption option) => PopupMenuItem<MenuOption>(
                      value: option,
                      child: RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  option.icon,
                                  color: Theme.of(context).accentColor,
                                ))),
                        TextSpan(
                            text: option.title,
                            style: Theme.of(context).textTheme.subtitle1)
                      ]))))
                  .toList())
        ],
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MenuOption {
  final String title;
  final IconData icon;
  // Takes context as required arg
  // Refactor/clean this
  final Function onTap;
  MenuOption({this.title, this.icon, this.onTap});
}

List<MenuOption> menuOptions = [
  MenuOption(
      title: 'Themes',
      icon: Icons.color_lens,
      onTap: (context) => {Navigator.pushNamed(context, '/themes')}),
  MenuOption(
      title: 'About',
      icon: Icons.info,
      onTap: (context) => {Navigator.pushNamed(context, '/about')})
];

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CalculatorModel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: CalculatorScreen()),
          Expanded(flex: 2, child: CalculatorKeyboard())
        ],
      ));
}

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).backgroundColor,
      child: Consumer<CalculatorModel>(
          builder: (context, calculator, child) => AutoSizeText(
              calculator.screenText,
              style: TextStyle(fontSize: 64))));
}

class CalculatorKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cm = CalculatorModel.of(context);

    return Keyboard(columnCount: 4, buttons: <Widget>[
      KeyboardButton(text: 'C', onPressed: () => cm.clear()),
      KeyboardButton(text: '()', onPressed: () => cm.appendParenthesis()),
      KeyboardButton(text: '%', onPressed: () => cm.appendPercentSymbol()),
      KeyboardButton(text: '÷', onPressed: () => cm.appendDivisionOperator()),
      KeyboardButton(text: '7', onPressed: () => cm.appendNum(7)),
      KeyboardButton(text: '8', onPressed: () => cm.appendNum(8)),
      KeyboardButton(text: '9', onPressed: () => cm.appendNum(9)),
      KeyboardButton(
          text: '×', onPressed: () => cm.appendMultiplicationOperator()),
      KeyboardButton(text: '4', onPressed: () => cm.appendNum(4)),
      KeyboardButton(text: '5', onPressed: () => cm.appendNum(5)),
      KeyboardButton(text: '6', onPressed: () => cm.appendNum(6)),
      KeyboardButton(
          text: '-', onPressed: () => cm.appendSubtractionOperator()),
      KeyboardButton(text: '1', onPressed: () => cm.appendNum(1)),
      KeyboardButton(text: '2', onPressed: () => cm.appendNum(2)),
      KeyboardButton(text: '3', onPressed: () => cm.appendNum(3)),
      KeyboardButton(text: '+', onPressed: () => cm.appendAdditionOperator()),
      KeyboardButton(text: '+/-', onPressed: () => cm.inverseSign()),
      KeyboardButton(text: '0', onPressed: () => cm.appendNum(0)),
      KeyboardButton(
          text: '.', onPressed: () => cm.appendDecimalSeparatorSymbol()),
      KeyboardButton(text: '=', onPressed: () => cm.findResult()),
    ]);
  }
}
