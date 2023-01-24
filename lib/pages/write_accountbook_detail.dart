import 'dart:core';
import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/pages/write_accountbook_detail.dart';
import 'package:good_zza_code_in_songdo/pages/write_accountbook_list.dart';
import 'package:intl/intl.dart';
import '../utills/number_format.dart';
import 'monthbudget_list.dart';

class WriteAccountbookDetail extends StatefulWidget {
  final String userInput;
  WriteAccountbookDetail(this.userInput, {Key? key}) : super(key: key);

  @override
  State<WriteAccountbookDetail> createState() => _WriteAccountbookDetailState();
}

class _WriteAccountbookDetailState extends State<WriteAccountbookDetail> {
  var userInput = '';
  var answer = '';

  bool isselected = false;

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = '';
  }

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
                Text("기록 추가",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ],
            )),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: '${numberFormat(widget.userInput)} 원',
                        ),
                      ),
                      TextField(
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                            labelText: '날짜',
                            suffixIcon: Icon(Icons.calendar_today),
                            //label text of field
                          ),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2023), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              print(
                                  formattedDate); //formatted date output using intl package =>  2022-07-04
                              //You can format date as per your need

                              setState(() {
                                dateController.text =
                                    formattedDate; //set foratted date to TextField value.
                              });
                            }
                          }),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: '설명',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(88, 212, 175, 1),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text("이전"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WriteAccountbookList(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(95, 89, 225, 1),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text("완료"),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
