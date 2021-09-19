import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:calculator/dto/input_operable.dart';

enum Operations {
  ac,
  percent,
  division,
  multiply,
  plus,
  minus,
  equals,
  power,
  period,
  undo,
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine
}

const redButtonColor = Color(0xFFFF4D4D);
const tealButtonColor = Colors.teal;

class CalculatorButton extends StatelessWidget {
  CalculatorButton(this.operationType, this.label, this.operationFunction,
      {this.labelColor = const Color(0xFFFFFFFF), this.icon});

  final Operations operationType;
  final Color labelColor;
  final String label;
  final Function operationFunction;
  final IconData? icon;

  static CalculatorButton ac(Function callback) {
    return CalculatorButton(Operations.one, 'AC', callback,
        labelColor: tealButtonColor);
  }

  static CalculatorButton percent(Function callback) {
    return CalculatorButton(Operations.percent, '%', () {
      callback(OperatorType.percent);
    },
        labelColor: tealButtonColor, icon: CupertinoIcons.percent);
  }

  static CalculatorButton division(Function callback) {
    return CalculatorButton(Operations.division, '÷', () {
      callback(OperatorType.divide);
    }, labelColor: redButtonColor, icon: CupertinoIcons.divide);
  }

  static CalculatorButton multiplication(Function callback) {
    return CalculatorButton(Operations.multiply, '×', () {
      callback(OperatorType.multiply);
    }, labelColor: redButtonColor, icon: CupertinoIcons.multiply);
  }

  static CalculatorButton minus(Function callback) {
    return CalculatorButton(Operations.minus, '-', () {
      callback(OperatorType.subtract);
    }, labelColor: redButtonColor, icon: CupertinoIcons.minus);
  }

  static CalculatorButton plus(Function callback) {
    return CalculatorButton(Operations.plus, '+', () {
      callback(OperatorType.add);
    }, labelColor: redButtonColor, icon: CupertinoIcons.plus);
  }

  static CalculatorButton equality(Function callback) {
    return CalculatorButton(Operations.equals, '=', callback,
        labelColor: redButtonColor, icon: CupertinoIcons.equal);
  }

  static CalculatorButton undo(Function callback) {
    return CalculatorButton(
      Operations.undo,
      '',
      callback,
      icon: CupertinoIcons.delete_left,
      labelColor: tealButtonColor,
    );
  }

  static CalculatorButton power(Function callback) {
    return CalculatorButton(Operations.power, '^', () {
      callback(OperatorType.power);
    });
  }

  static CalculatorButton period(Function callback) {
    return CalculatorButton(Operations.period, '.', callback);
  }

  static CalculatorButton zero(Function callback) {
    return CalculatorButton(Operations.one, '0', () {
      callback(0);
    });
  }

  static CalculatorButton one(Function callback) {
    return CalculatorButton(Operations.one, '1', () {
      callback(1);
    });
  }

  static CalculatorButton two(Function callback) {
    return CalculatorButton(Operations.two, '2', () {
      callback(2);
    });
  }

  static CalculatorButton three(Function callback) {
    return CalculatorButton(Operations.two, '3', () {
      callback(3);
    });
  }

  static CalculatorButton four(Function callback) {
    return CalculatorButton(Operations.two, '4', () {
      callback(4);
    });
  }

  static CalculatorButton five(Function callback) {
    return CalculatorButton(Operations.two, '5', () {
      callback(5);
    });
  }

  static CalculatorButton six(Function callback) {
    return CalculatorButton(Operations.two, '6', () {
      callback(6);
    });
  }

  static CalculatorButton seven(Function callback) {
    return CalculatorButton(Operations.two, '7', () {
      callback(7);
    });
  }

  static CalculatorButton eight(Function callback) {
    return CalculatorButton(Operations.two, '8', () {
      callback(8);
    });
  }

  static CalculatorButton nine(Function callback) {
    return CalculatorButton(Operations.two, '9', () {
      callback(9);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 50.0,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color(0x35000000),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: icon == null
          ? TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
                primary: labelColor,
              ),
              onPressed: () {
                operationFunction();
              },
              child: Text(label))
          : IconButton(
              icon: Icon(this.icon),
              iconSize: 20.0,
              color: labelColor,
              onPressed: () {
                operationFunction();
              },
            ),
    ));
  }
}
