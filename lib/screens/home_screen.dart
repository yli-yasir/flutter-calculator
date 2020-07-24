import 'package:flutter/material.dart';
import 'package:flutter_calculator/provider/calculator_model.dart';
import 'package:provider/provider.dart';
import '../widgets/keyboard.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => AppBar(
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

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

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
      color: Colors.amber,
      padding: EdgeInsets.all(16),
      child: Consumer<CalculatorModel>(
          builder: (context, calculator, child) =>
              Text(calculator.screenText)));
}

class CalculatorKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cm = CalculatorModel.of(context);

    return Keyboard(columnCount: 4, buttons: <Widget>[
      KeyboardButton(text: 'C', onPressed: () => cm.clear()),
      KeyboardButton(text: '()', onPressed: () => cm.appendParenthesis()),
      KeyboardButton(text: '%', onPressed: () => cm.appendPercentSymbol()),
      KeyboardButton(text: '÷', onPressed: () => cm.appendDivisionSymbol()),
      KeyboardButton(text: '7', onPressed: () => cm.appendNum(7)),
      KeyboardButton(text: '8', onPressed: () => cm.appendNum(8)),
      KeyboardButton(text: '9', onPressed: () => cm.appendNum(9)),
      KeyboardButton(
          text: '×', onPressed: () => cm.appendMultiplicationSymbol()),
      KeyboardButton(text: '4', onPressed: () => cm.appendNum(4)),
      KeyboardButton(text: '5', onPressed: () => cm.appendNum(5)),
      KeyboardButton(text: '6', onPressed: () => cm.appendNum(6)),
      KeyboardButton(text: '-', onPressed: () => cm.appendSubtractionSymbol()),
      KeyboardButton(text: '1', onPressed: () => cm.appendNum(1)),
      KeyboardButton(text: '2', onPressed: () => cm.appendNum(2)),
      KeyboardButton(text: '3', onPressed: () => cm.appendNum(3)),
      KeyboardButton(text: '+', onPressed: () => cm.appendAdditionSymbol()),
      KeyboardButton(text: '+/-', onPressed: () => cm.appendSignSymbol()),
      KeyboardButton(text: '0', onPressed: () => cm.appendNum(0)),
      KeyboardButton(
          text: '.', onPressed: () => cm.appendDecimalSeparatorSymbol()),
      KeyboardButton(text: '=', onPressed: () => cm.findResult()),
    ]);
  }

  void clear(BuildContext context) {
    CalculatorModel.of(context).clear();
  }

  void appendParenthesis(context) {
    CalculatorModel.of(context).appendParenthesis();
  }

  void appendPercentSymbol(context) {
    CalculatorModel.of(context).appendParenthesis();
  }

  void appendNum(BuildContext context, int num) {
    CalculatorModel.of(context).appendNum(num);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomeScreenAppBar(), body: HomeScreenBody());
  }
}
