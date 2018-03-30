import 'package:flutter/material.dart';
import 'CalculatorLogic.dart';
import 'CalculatorLayout.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Calculator Layout",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: new Calculator(),
    );
  }
}

