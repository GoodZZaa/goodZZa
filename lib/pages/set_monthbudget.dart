import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utills/number_format.dart';
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
        appBar: AppBar(
            leadingWidth: 70,
            centerTitle: true,
            actions: const [
              SizedBox(
                width: 70,
              )
            ],
            leading: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/icons/back_icon.png',
                    height: 25,
                  ),
                ),
                onTap: () => Navigator.pop(context)),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("예산 설정",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ],
            )),
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("이번달 예산은\n얼마인가요?",
                      style: TextStyle(
                          height: 1.3,
                          letterSpacing: 1.2,
                          fontSize: 25,
                          fontWeight: FontWeight.w900)),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      '${numberFormat(userInput)}원',
                      style: const TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '이번달 하루 생활비: ${numberFormat(dailyBudget(userInput))}원',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500),
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
                          child: Row(children: [
                            const Text(
                              '예산저장하기',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/icons/icon_plus.png',
                              height: 23,
                              width: 23,
                            ),
                          ]))
                    ],
                  ),
                  Flexible(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: buttons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            // Delete Button
                            if (index == 11) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    if (userInput != '') {
                                      userInput = userInput.substring(
                                          0, userInput.length - 1);
                                    }
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
                                  if (userInput.length < 9) {
                                    setState(() {
                                      userInput += buttons[index];
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('숫자가 너무 큽니다'),
                                      ),
                                    );
                                  }
                                  // userInputLength += userInput;
                                  // 리턴 bool로 만들어서 true면 값넣고
                                  // 길이가 6넘으면 아무 동작 안하게
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
                ])));
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
// function to calculate the input operation

}

String dailyBudget(String userInput) {
  if (userInput == '') {
    return '0';
  }
  double reUserInput = double.parse(userInput);
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
  return dailyBudget.floor().toString();
}

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

//Constructor
  const MyButton(
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
