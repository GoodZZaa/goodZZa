import 'dart:core';
import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/pages/write_accountbook_detail.dart';
import 'package:provider/provider.dart';
import '../provider/account_book_provider.dart';
import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';
import '../provider/receipt_camera_provider.dart';
import '../utills/number_format.dart';
import 'account_book2.dart';
import 'bottom_nav.dart';
import 'monthbudget_list.dart';

class Write_accountbook extends StatefulWidget {
  const Write_accountbook({Key? key}) : super(key: key);

  @override
  State<Write_accountbook> createState() => _Write_accountbookState();
}

class _Write_accountbookState extends State<Write_accountbook> {
  var userInput = '';
  var answer = '';

  bool isselected = false;

  int _index = 0;
  Color enableColor = Color.fromRGBO(88, 212, 175, 1); //your color
  Color disableColor = Colors.white; //your color

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
                onTap: () {
                  //저장
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                      create: (context) =>
                                          BottomNavigationProvider()),
                                  ChangeNotifierProvider(
                                      create: (context) => AccountProvider()),
                                  ChangeNotifierProvider(
                                      create: (context) =>
                                          ReceiptCameraProvider()),
                                  ChangeNotifierProvider(
                                      create: (context) => HomeProvider()),
                                ],
                                child: BottomNavigation(),
                              )),
                      (route) => false);
                }),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("기록 추가",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = 0;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: _index == 0
                                    ? Color.fromRGBO(88, 212, 175, 1)
                                    : Colors.white,
                                onPrimary:
                                    _index == 0 ? Colors.white : Colors.black,
                              ),
                              child: const Text(
                                '지출',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = 1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: _index == 1
                                    ? Color.fromRGBO(88, 212, 175, 1)
                                    : Colors.white,
                                onPrimary:
                                    _index == 1 ? Colors.white : Colors.black,
                              ),
                              child: const Text(
                                '수입',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: buttons.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('숫자가 너무 큽니다'),
                                            ),
                                          );
                                        }
                                      },
                                      buttonText: buttons[index],
                                      color: Colors.white);
                                }
                              }), // GridView.builder
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WriteAccountbookDetail(userInput),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(95, 89, 225, 1),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text("다음"),
                        ),
                      ]),
                ),
              ],
            )));
  }
}

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
