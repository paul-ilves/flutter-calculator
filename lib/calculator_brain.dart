import 'package:math_expressions/math_expressions.dart';

import 'dto/input_operable.dart';

class CalculatorBrain {
  List<OperableDto> inputList = [];
  Function setStateFunction;
  bool viewMode = false;

  CalculatorBrain(this.setStateFunction);

  void inputDigit(int inputDigit) {
    viewMode = false;
    if (inputList.isEmpty || inputList.last is OperatorDto) {
      inputList.add(NumberDto(inputDigit.toString()));
      return;
    }

    var lastDigit = inputList.last;
    if (lastDigit is NumberDto) {
      if (inputDigit == 0 && lastDigit.isZero()) {
        return;
      }

      lastDigit.appendDigit(inputDigit.toString());
      return;
    }
  }

  void inputOperator(OperatorType operatorType) {
    viewMode = false;
    if (inputList.isEmpty) {
      if (operatorType == OperatorType.subtract) {
        inputList.add(OperatorDto(operatorType));
        return;
      }
      return;
    }

    if (inputList.last is OperatorDto) {
      inputList.last = OperatorDto(operatorType);
      return;
    }

    if (inputList.last is NumberDto) {
      inputList.add(OperatorDto(operatorType));
      return;
    }

    print('Weird case (2) (¬_¬ )');
    return;
  }

  void inputPeriod() {
    viewMode = false;
    var lastInput = inputList.last;
    if (lastInput is OperatorDto) {
      return;
    }

    if (lastInput is NumberDto) {
      lastInput.appendPeriod();
      return;
    }
  }

  void clearInput() {
    viewMode = false;
    inputList.clear();
  }

  void removeLastInputSymbol() {
    if(viewMode) {
      clearInput();
      return;
    }

    var lastInputSymbol = inputList.last;

    if (lastInputSymbol is OperatorDto) {
      inputList.removeLast();
      return;
    }

    if (lastInputSymbol is NumberDto) {
      lastInputSymbol.removeLastDigit();
      return;
    }
  }

  String stringifyInputList({bool addSpacesBetweenOperables = false}) {
    String output = '';

    inputList.forEach((element) {
      output += element.toString();
      if(addSpacesBetweenOperables) {
        output += ' ';
      }
    });
    return output;
  }

  double calculateResult({bool removeTrailingOperator = false}) {
    Parser p = Parser();
    String stringifiedInput = this
        .stringifyInputList()
        .replaceAllMapped(RegExp(r'(\d+)%(\d+)'), (match) {
          return '${match.group(1)}*${match.group(2)}*0.01';
        })
        .replaceAllMapped(RegExp(r'(\d+)\+(\d+)%'), (match) {
          print('group 1: ${match.group(1)}');
          print('group 2: ${match.group(2)}');
          return '${match.group(1)}+${match.group(1)}*${match.group(2)}*0.01';
        })
        .replaceAll('×', '*')
        .replaceAll('÷', '/');
    print(stringifiedInput);
    if (removeTrailingOperator && _endsWithOperator(stringifiedInput)) {
      stringifiedInput =
          stringifiedInput.substring(0, stringifiedInput.length - 1);
    }
    Expression exp = p.parse(stringifiedInput);

    return exp.evaluate(EvaluationType.REAL, ContextModel());
  }

  bool _endsWithOperator(String stringifiedInput) {
    return stringifiedInput.endsWith("+") ||
        stringifiedInput.endsWith("-") ||
        stringifiedInput.endsWith("/") ||
        stringifiedInput.endsWith("^") ||
        stringifiedInput.endsWith("*");
  }

  void showResult() {
    double result = calculateResult(removeTrailingOperator: true);
    String resultString = result - result.toInt() == 0
        ? result.toStringAsFixed(0)
        : result.toString();
    this.inputList = [NumberDto(resultString)];
    viewMode = true;
  }
}
