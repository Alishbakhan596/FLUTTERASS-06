import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class CalculatorUI extends StatefulWidget {
  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  String number1 = ""; // . 0-9
  String operand = ""; // = - * /
  String number2 = ""; // . 0-9

  @override
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          CalculatorUI(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          // primary: btncolor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //calculator display
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 100),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton(
                    'C',
                    Colors.grey,
                    Colors.black,
                  ),
                  calcbutton('+/-', Colors.grey, Colors.black),
                  calcbutton('%', Colors.grey, Colors.black),
                  calcbutton('/', Colors.grey, Colors.black),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('7', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('8', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('9', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('x', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('4', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('5', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('6', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('-', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('1', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('2', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('3', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('+', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton('AC', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('0', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('.', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                  calcbutton('=', const Color.fromARGB(150, 158, 158, 158),
                      Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //here we will write calculator logic for the app
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void CalculatorUI(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
