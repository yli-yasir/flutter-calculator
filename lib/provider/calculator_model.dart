import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

// For easily changing in the future and avoiding spelling errors (blank spaces to sides etc)
const OPENING_PARENTHESIS = '(';
const CLOSING_PARENTHESIS = ')';
const DECIMAL_SEPERATOR_SYMBOL = '.';
const PERCENT_SYMBOL = '%';
const ADDITION_SYMBOL = '+';
const SUBTRACTION_SYMBOL = '-';
const MULTIPLICATION_PROGRAMMING_SYMBOL = '*';
const MULTIPLICATION_SCREEN_SYMBOL = '×';
const DIVISION_PROGRAMMING_SYMBOL = '/';
const DIVISION_SCREEN_SYMBOL = '÷';
const NEGATIVE_SCREEN_SIGN = '(-';

// Map to retrieve a list of either via .keys() or .values()
// % is an edgecase because it completely has different meanings
// in the programming world. In this app it's considered numerical (/100)
// so it won't be added below as an operator
const Map<String, String> screenToProgramOperators = {
  ADDITION_SYMBOL: ADDITION_SYMBOL,
  SUBTRACTION_SYMBOL: SUBTRACTION_SYMBOL,
  MULTIPLICATION_SCREEN_SYMBOL: MULTIPLICATION_PROGRAMMING_SYMBOL,
  DIVISION_SCREEN_SYMBOL: DIVISION_PROGRAMMING_SYMBOL
};

final RegExp screenOperatorsRegex = _buildScreenOperatorRegex();

// Matches any screen operator
RegExp _buildScreenOperatorRegex() {
  var src = '(';
  final screenOperators = screenToProgramOperators.keys.toList();
  for (var i = 0; i < screenOperators.length; i++) {
    src += '\\' + screenOperators[i];
    if (i + 1 >= screenOperators.length) {
      src += ')';
    } else {
      src += '|';
    }
  }
  return RegExp(src);
}

bool isScreenOperator(String screenOperator) {
  return screenToProgramOperators.containsKey(screenOperator);
}

// All numbers + '%'
bool isNumeric(String char) {
  return num.tryParse(char) != null || char == PERCENT_SYMBOL;
}

bool isParenthesis(String char) {
  return char == OPENING_PARENTHESIS || char == CLOSING_PARENTHESIS;
}

String lastChar(String string) {
  return string.isNotEmpty ? string.trimRight()[string.length - 1] : '';
}

class CalculatorModel extends ChangeNotifier {
  String screenText = '';
  int _unclosedParenthesisCount = 0;
  bool hasFoundResult = false;

  //Notifier function
  void clear() {
    screenText = '';
    _unclosedParenthesisCount = 0;
    notifyListeners();
  }

  // Notifier function
  void findResult() {
    if (hasUnclosedParenthesis()) {
      return;
    }
    final mathExp = Parser().parse(screenTextToMathExpString());

    screenText =
        mathExp.evaluate(EvaluationType.REAL, ContextModel()).toString();
    hasFoundResult = true;
    notifyListeners();
  }

  String screenTextToMathExpString() {
    var mathExp = screenText;

    // We add the '%' here, as mentioned above it's an edge case
    // and should be treated carefully
    final screenToProgramReplacements = {
      ...screenToProgramOperators,
      '%': '/100'
    };

    for (var replacementKey in screenToProgramReplacements.keys) {
      mathExp = mathExp.replaceAll(
          replacementKey, screenToProgramReplacements[replacementKey]);
    }

    return mathExp;
  }

  // --- Notifier function ---
  void appendNum(int num) {
    if (hasFoundResult) {
      hasFoundResult = false;
      clear();
    }
    // Handle implicit multiplication
    if (screenTextLastChar == CLOSING_PARENTHESIS ||
        screenTextLastChar == PERCENT_SYMBOL) {
      appendMultiplicationOperator();
    }

    screenText += num.toString();

    notifyListeners();
  }
  //  ----  ----  ----  ----

  // --- Notifier function ---
  void _appendSymbol(screenTextSymbol) {
    // 1- If the screenText already ends with the symbol then don't add it again
    // 2- Don't add a symbol after a non numerical and non operator
    // Case 2 is due to having to add for the purpose of replacing
    if (screenTextLastChar == screenTextSymbol) {
      return;
    }

    //  We append the new operator
    screenText += screenTextSymbol;
    notifyListeners();
  }

  void appendPercentSymbol() {
    if (isNumeric(screenTextLastChar)) {
      _appendSymbol(PERCENT_SYMBOL);
    }
  }

  void appendDecimalSeparatorSymbol() {
    var symbol = DECIMAL_SEPERATOR_SYMBOL;
    // Handle implicit multiplication
    // We are always allowed to add the seperator in this case.
    if (screenTextLastChar == PERCENT_SYMBOL ||
        screenTextLastChar == CLOSING_PARENTHESIS) {
      symbol = MULTIPLICATION_SCREEN_SYMBOL + '0' + DECIMAL_SEPERATOR_SYMBOL;
    }
    // Handle implicit 0.<num> value
    // If the user enters a decimal seperator after an operator or opening parenthesis it's regarded
    // as impicitly 0.<user can continue to write here>
    else if (isScreenOperator(screenTextLastChar) ||
        screenTextLastChar == OPENING_PARENTHESIS) {
      symbol = '0' + DECIMAL_SEPERATOR_SYMBOL;
    }
    // If the above cases are not true then we have to consider that
    // we can only add a seperator once to each number
    // We determine if we had already used one by comparing the
    // index of the last operator with the index of the last operator
    else if (screenText.lastIndexOf(DECIMAL_SEPERATOR_SYMBOL) >
        screenText.lastIndexOf(screenOperatorsRegex)) {
      return;
    }
    _appendSymbol(symbol);
  }

  void _appendOperator(screenTextOperator) {
    if (hasFoundResult) {
      hasFoundResult = false;
    }
    // An operator should not come after a decimal seperator or opening parenthesis
    // An operator should not come at the start of the expression
    if (screenTextLastChar == OPENING_PARENTHESIS ||
        screenTextLastChar == DECIMAL_SEPERATOR_SYMBOL ||
        screenText.isEmpty) {
      return;
    }
    // If the screenText ends with an operator
    if (isScreenOperator(screenTextLastChar)) {
      screenText = screenText.substring(0, screenText.length - 1);
    }
    _appendSymbol(screenTextOperator);
  }

  void appendMultiplicationOperator() {
    _appendOperator(MULTIPLICATION_SCREEN_SYMBOL);
  }

  void appendDivisionOperator() {
    _appendOperator(DIVISION_SCREEN_SYMBOL);
  }

  void appendAdditionOperator() {
    _appendOperator(ADDITION_SYMBOL);
  }

  void appendSubtractionOperator() {
    _appendOperator(SUBTRACTION_SYMBOL);
  }
//  ----  ----  ----  ----

  // ---- Signs ----
  // Notifier function
  void inverseSign() {
    if (hasFoundResult) {
      hasFoundResult = false;
    }
    //Find the index of the last operator
    final lastOperatorIndex = screenText.lastIndexOf(screenOperatorsRegex);
    //If there is no operator, then just add the sign at the start of the string
    if (lastOperatorIndex == -1) {
      _insertNegativeSign(0);
    }
    // If last char is a closing parenthesis , then we append the sign
    else if (screenTextLastChar == CLOSING_PARENTHESIS) {
      _insertNegativeSign(screenText.length);
    }
    // Take a substring of the last operator and the character proceding it
    // It might actually be a sign a not an operator
    // If the operator is a subtraction symbol with an open parenthesis preceding it
    // then it is acutally part of the negative symbol which should be removed
    else if (screenText.substring(
            lastOperatorIndex - 1, lastOperatorIndex + 1) ==
        NEGATIVE_SCREEN_SIGN) {
      final negativeSignIndex = lastOperatorIndex - 1;
      _removeNegativeSign(negativeSignIndex);
    }
    // If it was not a sign then it must be an operator, which means
    // the number after the sign is implicitly positive due to lack of sign
    // We add a negative sign after the operator
    else {
      _insertNegativeSign(lastOperatorIndex + 1);
    }
    notifyListeners();
  }

  void _insertNegativeSign(index) {
    final screenTextList = screenText.split('');
    var sign = NEGATIVE_SCREEN_SIGN;
    if (screenTextLastChar == CLOSING_PARENTHESIS) {
      sign = MULTIPLICATION_SCREEN_SYMBOL + NEGATIVE_SCREEN_SIGN;
    }
    screenTextList.insert(index, sign);
    screenText = screenTextList.join();
    // Negative sign includes an open parenthesis
    _unclosedParenthesisCount++;
  }

  void _removeNegativeSign(index) {
    final screenTextList = screenText.split('');
    screenTextList.removeRange(index, index + 2);
    screenText = screenTextList.join();
    // Removing the negative sign removes it's parenthesis with it
    _unclosedParenthesisCount--;
  }
  //  ----  ----  ----  ----

  // ---- Parenthesis -----
  // Notifier function
  void appendParenthesis() {
    if (hasFoundResult) {
      hasFoundResult = false;
    }
    if (screenTextLastChar == DECIMAL_SEPERATOR_SYMBOL) {
      return;
    }
    // if we have unclosed parenthesis
    // Close Parenthesis if the last character is a number
    // Also prefer to close then if the last character is a closing parenthesis
    else if (hasUnclosedParenthesis() &&
        (isNumeric(screenTextLastChar) ||
            screenTextLastChar == CLOSING_PARENTHESIS)) {
      _appendClosingParenthesis();
    } else {
      _appendOpeningParenthesis();
    }
    notifyListeners();
  }

  void _appendOpeningParenthesis() {
    if (screenTextLastChar == CLOSING_PARENTHESIS ||
        isNumeric(screenTextLastChar)) {
      appendMultiplicationOperator();
    }
    screenText += OPENING_PARENTHESIS;
    _unclosedParenthesisCount++;
  }

  void _appendClosingParenthesis() {
    screenText += CLOSING_PARENTHESIS;
    _unclosedParenthesisCount--;
  }

  bool hasUnclosedParenthesis() {
    return _unclosedParenthesisCount > 0;
  }

//  ----  ----  ----  ----

  get screenTextLastChar {
    return lastChar(screenText);
  }

  static CalculatorModel of(BuildContext context) =>
      Provider.of<CalculatorModel>(context, listen: false);
}
