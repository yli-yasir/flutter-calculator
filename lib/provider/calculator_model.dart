import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorModel extends ChangeNotifier {
  String screenText = '';
  String _mathExpression = '';
  int _unclosedParenthesisCount = 0;

  // For easily changing in the future and avoiding spelling errors (blank spaces to sides etc)
  static const OPENING_PARENTHESIS = '(';
  static const CLOSING_PARENTHESIS = ')';
  static const DECIMAL_SEPERATOR = '.';
  static const PERCENT_SYMBOL = '%';

  void clear() {
    screenText = '';
    _mathExpression = '';
    _unclosedParenthesisCount = 0;
    notifyListeners();
  }

  void findResult() {}

  void appendNum(int num) {
    print(screenTextLastChar);
    if (screenTextLastChar == CLOSING_PARENTHESIS ||
        screenTextLastChar == PERCENT_SYMBOL) {
      appendMultiplicationSymbol();
    }
    screenText += num.toString();
    _mathExpression += num.toString();
    notifyListeners();
  }

  void _appendSymbol({screenTextSymbol, mathExpressionSymbol}) {
    screenText += screenTextSymbol;
    _mathExpression += mathExpressionSymbol ?? screenTextSymbol;
    notifyListeners();
  }

  // Each function for adding symbols is defined seperately because
  // what needs to be appended to [_mathExpression] can be different
  // than what needs to be appended to the [screenText]
  void appendMultiplicationSymbol() {
    _appendSymbol(screenTextSymbol: '×', mathExpressionSymbol: '*');
  }

  void appendDivisionSymbol() {
    _appendSymbol(screenTextSymbol: '÷', mathExpressionSymbol: '/');
  }

  void appendAdditionSymbol() {
    _appendSymbol(screenTextSymbol: '+');
  }

  void appendSubtractionSymbol() {
    _appendSymbol(screenTextSymbol: '-');
  }

  void appendPercentSymbol() {
    _appendSymbol(screenTextSymbol: '%', mathExpressionSymbol: '/100');
  }

  void appendDecimalSeparatorSymbol() {
    _appendSymbol(screenTextSymbol: '.');
  }

  void appendSignSymbol() {}

  void appendParenthesis() {
    if (hasUnclosedParenthesis() &&
        (isLastCharNumeric() || screenTextLastChar == CLOSING_PARENTHESIS)) {
      _appendClosingParenthesis();
    } else {
      _appendOpeningParenthesis();
    }
    notifyListeners();
  }

  void _appendOpeningParenthesis() {
    if (screenTextLastChar == CLOSING_PARENTHESIS || isLastCharNumeric()) {
      appendMultiplicationSymbol();
    }
    screenText += OPENING_PARENTHESIS;
    _mathExpression += OPENING_PARENTHESIS;
    _unclosedParenthesisCount++;
  }

  void _appendClosingParenthesis() {
    screenText += CLOSING_PARENTHESIS;
    _mathExpression += CLOSING_PARENTHESIS;
    _unclosedParenthesisCount--;
  }

  bool isLastCharNumeric() {
    return num.tryParse(screenTextLastChar) != null;
  }

  bool hasUnclosedParenthesis() {
    return _unclosedParenthesisCount > 0;
  }

  get screenTextLastChar {
    return screenText.isNotEmpty
        ? screenText.trimRight()[screenText.length - 1]
        : '';
  }

  static CalculatorModel of(BuildContext context) =>
      Provider.of<CalculatorModel>(context, listen: false);
}
