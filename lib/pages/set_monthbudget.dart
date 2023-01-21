import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

class SetMonthBudget extends StatefulWidget {
  const SetMonthBudget({Key? key}) : super(key: key);

  @override
  State<SetMonthBudget> createState() => _SetMonthBudgetState();
}

class _SetMonthBudgetState extends State<SetMonthBudget> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '00',
    '0',
    'DEL',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.lightBlue,
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("예산설정",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ), //AppBar
      backgroundColor: Colors.white,

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(14)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("이번 달 예산은",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 1),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("얼마인가요?",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(100),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        userInput,
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '원',
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  alignment: Alignment.centerLeft,
                  child: (userInput == '')
                      ? Text('이번달 하루 생활비 0원')
                      : Text(
                          '이번달 하루 생활비' + DailyBudget(userInput) + '원',
                          style: TextStyle(color: Colors.red),
                        ),
                ),
              ]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 4),
                ),
                itemBuilder: (BuildContext context, int index) {
                  // Delete Button
                  if (index == 11) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white,
                      textColor: Colors.black,
                    );
                  }
                  // other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                          print(userInput);
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                }), // GridView.builder
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation

}

String DailyBudget(String? userInput) {
  double reUserInput = double.parse(userInput!);
  double dailyBudget = reUserInput / 30;

  String res = "";
  res = (dailyBudget.floor()).toString();

  return res;
}

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

//Constructor
  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
