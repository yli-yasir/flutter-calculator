import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final int columnCount;
  final List<Widget> buttons;

  Keyboard({this.buttons, this.columnCount});

  @override
  Widget build(BuildContext context) {
    final List<Widget> populatedRows = _makeRows();

    return Column(
      children: populatedRows,
    );
  }

  int get rowCount => (buttons.length / columnCount).ceil();

  List<Widget> _makeRows() {
    final flexibleRows = <Widget>[];
    for (int i = 0; i < rowCount; i++) {
      final rowChildren =
          buttons.skip(i * columnCount).take(columnCount).toList();
      flexibleRows.add(Expanded(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rowChildren)));
    }
    return flexibleRows;
  }
}

class KeyboardButton extends StatelessWidget {
  final String text;
  final onPressed;
  KeyboardButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) => Expanded(
          child: OutlineButton(
        child: Text(text),
        onPressed: onPressed,
      ));
}
