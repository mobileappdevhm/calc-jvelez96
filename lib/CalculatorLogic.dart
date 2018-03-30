import 'package:flutter/material.dart';
import 'CalculatorLayout.dart';

class Calculator extends StatefulWidget {
  @override
  CalcState createState() => new CalcState();
}

class CalcState extends State<Calculator> {
  String inputString = ""; //entire string on the display
  double prevValue;  //temporary variable used to achieve the result
  String value = ""; //another temporary variable used to achieve the result
  String op = 'z'; //operation symbol

  //verifies if the string is a number
  bool isNumber(String str) {
    if (str == null) {
      return false;
    }
    return double.parse(str, (e) => null) != null;
  }

  //defines the action when each button is pressed
  void onPressed(keyvalue) {
    switch (keyvalue) {
      case "AC":
        op = null;
        prevValue = 0.0;
        value = "";
        setState(() => inputString = "");
        break;
      case ".":
        setState(()=> inputString += ".");
        break;
      case "%":
      case "+/-":

        //verifies if the string has a minus or not in the beggining and changes it to the other
        if(inputString.substring(0,1) == "-")
          setState(() => inputString = ""+inputString.substring(1));
        else if(inputString.substring(0,1) == "+")
          setState(() => inputString = "-"+inputString.substring(1));
        else
          setState(() => inputString = "-"+inputString.substring(0));
        break;
      case "x":
      case "+":
      case "-":
      case "/":
        op = keyvalue;
        value = '';
        prevValue = double.parse(inputString);
        setState(() {
          inputString = inputString + keyvalue;
        });
        break;
      case "=":
        if (op != null) {
          setState(() {

            // when the '=' is pressed, checks which operation is used and solves the expression
            switch (op) {
              case "x":
                inputString =
                    (prevValue * double.parse(value)).toStringAsFixed(2);
                break;
              case "+":
                print(prevValue);
                inputString =
                    (prevValue + double.parse(value)).toStringAsFixed(2);
                break;
              case "-":
                inputString =
                    (prevValue - double.parse(value)).toStringAsFixed(2);
                break;
              case "/":
                inputString =
                    (prevValue / double.parse(value)).toStringAsFixed(2);
                break;
            }
          });
          op = null;
          prevValue = double.parse(inputString);
          value = '';
          break;
        }
        break;
      default:
        if (isNumber(keyvalue)) {
          if (op != null) {
            setState(() => inputString = inputString + keyvalue);
            value = value + keyvalue;
          } else {
            setState(() => inputString = "" + keyvalue);
            op = 'z';
          }
        } else {
          onPressed(keyvalue);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MainState(
      inputValue: inputString,
      prevValue: prevValue,
      value: value,
      op: op,
      onPressed: onPressed,
      child: new CalculatorLayout(),
    );
  }
}

class MainState extends InheritedWidget {
  MainState({
    Key key,
    this.inputValue,
    this.prevValue,
    this.value,
    this.op,
    this.onPressed,
    Widget child,
  }) : super(key: key, child: child);

  final String inputValue;
  final double prevValue;
  final String value;
  final String op;
  final Function onPressed;

  static MainState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MainState);
  }

  @override
  bool updateShouldNotify(MainState oldWidget) {
    return inputValue != oldWidget.inputValue;
  }
}

