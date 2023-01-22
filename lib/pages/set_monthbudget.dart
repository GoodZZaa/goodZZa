import 'dart:core';

import 'package:flutter/material.dart';

import 'monthbudget_list.dart';

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
            color: Colors.deepPurpleAccent,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(14)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("이번달 예산은",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold))),
                      SizedBox(height: 1),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("얼마인가요?",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold))),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Monthbudget_List(userInput),
                            ),
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            child: Row(children: [
                              Image.asset(
                                'assets/icons/icon_plus.png',
                                height: 26,
                                width: 26,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                '예산저장하기',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                            ])))
                  ],
                ),
              ),
            ]),
          ),
          Flexible(
            child: Container(
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
                          List<String> userInputLength;
                          setState(() {
                            userInput += buttons[index];

                            // userInputLength += userInput;
                            // 리턴 bool로 만들어서 true면 값넣고
                            // 길이가 6넘으면 아무 동작 안하게
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
  double dailyBudget = 0;
  if (reUserInput == DateTime.january ||
      reUserInput == DateTime.march ||
      reUserInput == DateTime.may ||
      reUserInput == DateTime.july ||
      reUserInput == DateTime.august ||
      reUserInput == DateTime.september ||
      reUserInput == DateTime.october ||
      reUserInput == DateTime.december) {
    dailyBudget = reUserInput / 31;
  } else if (reUserInput == DateTime.february) {
    dailyBudget = reUserInput / 28;
  } else {
    dailyBudget = reUserInput / 30;
  }

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
