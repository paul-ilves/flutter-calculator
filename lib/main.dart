import 'package:calculator/calculator_brain.dart';
import 'package:calculator/dto/input_operable.dart';
import 'package:flutter/material.dart';

import 'component/calculator_button.dart';

const Color backgroundColor = Color(0xFF22252D);
const Color foregroundColor = Color(0xFF2F333B);

//TODO add brackets
//TODO fix bug allowing multiple consequent operators
//TODO fix bug when first symbol entered is a period
//TODO fix rounding bugs

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CalculatorBrain calculatorBrain;

  @override
  void initState() {
    super.initState();
    calculatorBrain = CalculatorBrain(inputDigitCallback);
  }

  void inputDigitCallback(int digitToInput) {
    setState(() {
      calculatorBrain.inputDigit(digitToInput);
    });
  }

  void inputOperatorCallback(OperatorType operatorType) {
    setState(() {
      calculatorBrain
          .inputOperator(operatorType);
    });
  }

  void clearInputCallback() {
    setState(() {
      calculatorBrain.clearInput();
    });
  }

  void removeLastInputSymbol() {
    setState(() {
      calculatorBrain.removeLastInputSymbol();
    });
  }

  void addPeriod() {
    setState(() {
      calculatorBrain.inputPeriod();
    });
  }

  void showResult() {
    setState(() {
      calculatorBrain.showResult();
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handy Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    child: Text(
                      calculatorBrain.stringifyInputList(addSpacesBetweenOperables: true),
                      style: TextStyle(color: Colors.white, fontSize: 34),
                    ),
                    padding: EdgeInsets.only(left: 70.0, bottom: 30.0),
                  )
                ],
              ),
              flex: 7,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: foregroundColor,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.0),
                      Row(
                        children: [
                          CalculatorButton.ac(clearInputCallback),
                          CalculatorButton.undo(removeLastInputSymbol),
                          CalculatorButton.percent(inputOperatorCallback),
                          CalculatorButton.division(inputOperatorCallback),
                        ],
                      ),
                      Row(
                        children: [
                          CalculatorButton.seven(inputDigitCallback),
                          CalculatorButton.eight(inputDigitCallback),
                          CalculatorButton.nine(inputDigitCallback),
                          CalculatorButton.multiplication(inputOperatorCallback),
                        ],
                      ),
                      Row(
                        children: [
                          CalculatorButton.four(inputDigitCallback),
                          CalculatorButton.five(inputDigitCallback),
                          CalculatorButton.six(inputDigitCallback),
                          CalculatorButton.minus(inputOperatorCallback),
                        ],
                      ),
                      Row(
                        children: [
                          CalculatorButton.one(inputDigitCallback),
                          CalculatorButton.two(inputDigitCallback),
                          CalculatorButton.three(inputDigitCallback),
                          CalculatorButton.plus(inputOperatorCallback),
                        ],
                      ),
                      Row(
                        children: [
                          CalculatorButton.power(inputOperatorCallback),
                          CalculatorButton.zero(inputDigitCallback),
                          CalculatorButton.period(addPeriod),
                          CalculatorButton.equality(showResult),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              flex: 6,
            )
          ],
        ),
      ),
    );
  }
}
