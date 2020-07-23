import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleCalc(),
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}

class SimpleCalc extends StatefulWidget {
  @override
  _SimpleCalcState createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationSize = 38;
  double resultSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationSize = 38;
        resultSize = 48;
      } else if (buttonText == 'del') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = '0';
        }
        equationSize = 48;
        resultSize = 38;
      } else if (buttonText == '=') {
        equationSize = 38;
        resultSize = 48;
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {}
      } else {
        equationSize = 48;
        resultSize = 38;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      // color: buttonColor,
      child: FlatButton(color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
                color: Colors.white38, width: 1, style: BorderStyle.solid),
          ),
          child: Text(buttonText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30)),
          onPressed: () => buttonPressed(buttonText),
          padding: EdgeInsets.all(16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("del", 1, Colors.grey),
                      buildButton("÷", 1, Colors.orangeAccent)
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.brown),
                      buildButton("8", 1, Colors.brown),
                      buildButton("9", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.brown),
                      buildButton("5", 1, Colors.brown),
                      buildButton("6", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.brown),
                      buildButton("2", 1, Colors.brown),
                      buildButton("3", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.brown),
                      buildButton("0", 1, Colors.brown),
                      buildButton("00", 1, Colors.brown)
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.red),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
