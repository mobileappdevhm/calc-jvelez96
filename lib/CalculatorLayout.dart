import 'package:flutter/material.dart';
import 'CalculatorLogic.dart';

//creates the calculator buttons and output
class CalculatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainState = MainState.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              color: Colors.lightBlue[300].withOpacity(0.85),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    mainState.inputValue ?? '0',
                    style: new TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 48.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 4,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  makeBtns('~='),
                  makeBtns('789x'),
                  makeBtns('456-'),
                  makeBtns('123+'),
                  makeBtns('_0./'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget makeBtns(String row) {
    List<String> token = row.split("");
    return new Expanded(
      flex: 1,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token
            .map((e) => new CalcButton(
          keyvalue: e == '_' ? "+/-" : e == '~' ? 'AC' : e,
        ))
            .toList(),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  CalcButton({this.keyvalue});

  final String keyvalue;

  @override
  Widget build(BuildContext context) {
    final mainState = MainState.of(context);
    return new Expanded(
      flex: 1,
      child: new FlatButton(
        shape: new Border.all(
          color: Colors.cyan[200].withOpacity(0.5),
          width: 2.0,
          style: BorderStyle.solid,
        ),
        color: Colors.cyan[400],
        child: new Text(
          keyvalue,
          style: new TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 36.0,
            color: Colors.black54,
            fontStyle: FontStyle.normal,
          ),
        ),
        onPressed: () {
          mainState.onPressed(keyvalue);
        },
      ),
    );
  }
}

