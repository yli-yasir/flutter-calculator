import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final int columnCount;
  final List<Widget> buttons;

  Keyboard({this.buttons, this.columnCount});

  @override
  Widget build(BuildContext context) {
    final List<Widget> flexibleRows = _makeRows();

    return Column(
      children: flexibleRows,
    );
  }

  int get rowCount => (buttons.length / columnCount).ceil();

  List<Widget> _makeRows() {
    final flexibleRows = <Widget>[];
    for (int i = 0; i < rowCount; i++) {
      final rowChildren =
          buttons.skip(i * columnCount).take(columnCount).toList();
      flexibleRows.add(Flexible(
          fit: FlexFit.tight,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rowChildren)));
    }
    return flexibleRows;
  }
}
