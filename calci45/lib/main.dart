import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String output = "0";
  bool isResultShown = false;
  List<String> history = [];

  void onButtonClick(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "0";
        isResultShown = false;
      } else if (value == "⌫") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == "=") {
        try {
          String expression = input.replaceAll("×", "*").replaceAll("÷", "/");
          List<String> tokens = tokenize(expression);
          double result = computeResult(tokens);
          output =
              result % 1 == 0 ? result.toInt().toString() : result.toString();

          // Save to history
          history.insert(0, "$input = $output");

          isResultShown = true;
        } catch (e) {
          output = "Error";
        }
      } else {
        if (isResultShown) {
          if ("0123456789.".contains(value)) {
            input = value;
          } else {
            input = output + value;
          }
          isResultShown = false;
        } else {
          input += value;
        }
      }
    });
  }

  List<String> tokenize(String expr) {
    List<String> tokens = [];
    String num = "";
    for (int i = 0; i < expr.length; i++) {
      String char = expr[i];
      if ("0123456789.".contains(char)) {
        num += char;
      } else {
        if (num.isNotEmpty) {
          tokens.add(num);
          num = "";
        }
        tokens.add(char);
      }
    }
    if (num.isNotEmpty) tokens.add(num);
    return tokens;
  }

  double computeResult(List<String> tokens) {
    List<String> outputQueue = [];
    List<String> operatorStack = [];
    Map<String, int> precedence = {"+": 1, "-": 1, "*": 2, "/": 2, "%": 2};

    for (String token in tokens) {
      if (double.tryParse(token) != null) {
        outputQueue.add(token);
      } else if (precedence.containsKey(token)) {
        while (operatorStack.isNotEmpty &&
            precedence.containsKey(operatorStack.last) &&
            precedence[token]! <= precedence[operatorStack.last]!) {
          outputQueue.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      } else if (token == "(") {
        operatorStack.add(token);
      } else if (token == ")") {
        while (operatorStack.isNotEmpty && operatorStack.last != "(") {
          outputQueue.add(operatorStack.removeLast());
        }
        if (operatorStack.isNotEmpty && operatorStack.last == "(") {
          operatorStack.removeLast();
        }
      }
    }

    while (operatorStack.isNotEmpty) {
      outputQueue.add(operatorStack.removeLast());
    }

    // Evaluate RPN
    List<double> stack = [];
    for (String token in outputQueue) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else {
        double b = stack.removeLast();
        double a = stack.removeLast();
        stack.add(applyOp(token, b, a));
      }
    }

    return stack.first;
  }

  int precedence(String op) {
    if (op == "+" || op == "-") return 1;
    if (op == "*" || op == "/" || op == "%") return 2;
    return 0;
  }

  double applyOp(String op, double b, double a) {
    switch (op) {
      case "+":
        return a + b;
      case "-":
        return a - b;
      case "*":
        return a * b;
      case "/":
        return b == 0 ? 0 : a / b;
      case "%":
        return a % b;
      default:
        return 0;
    }
  }

  Widget buildButton(String text, {Color color = Colors.white}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onButtonClick(text),
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHistory() {
    return Container(
      height: 120,
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Text(
            history[index],
            style: TextStyle(fontSize: 16, color: Colors.white70),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calci45"),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: "Clear History",
            onPressed: () {
              setState(() {
                history.clear();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          buildHistory(),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white),
          Column(
            children: [
              Row(
                children:
                    ["C", "⌫", "%", "÷"]
                        .map((e) => buildButton(e, color: Colors.redAccent))
                        .toList(),
              ),
              Row(children: ["7", "8", "9", "×"].map(buildButton).toList()),
              Row(children: ["4", "5", "6", "-"].map(buildButton).toList()),
              Row(children: ["1", "2", "3", "+"].map(buildButton).toList()),
              Row(
                children:
                    ["(", ")", "0", ".", "="]
                        .map((e) => buildButton(e, color: Colors.greenAccent))
                        .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
