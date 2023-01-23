import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_zza_code_in_songdo/models/month_budget_item.dart';
import 'package:good_zza_code_in_songdo/provider/budget_list_provider.dart';
import 'package:good_zza_code_in_songdo/utills/number_format.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';
import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';
import '../provider/receipt_camera_provider.dart';
import 'bottom_nav.dart';

class MonthBudgetList extends StatefulWidget {
  final String userInput;
  MonthBudgetList(this.userInput, {Key? key}) : super(key: key);

  @override
  State<MonthBudgetList> createState() => _MonthBudgetListState();
}

final List<Data> _choiceChipsList = [
  Data("식료품", Colors.lightBlueAccent),
  Data("교통비", Colors.amberAccent),
  Data("생필품", Colors.lime),
  Data("취미", Colors.cyan),
  Data("기타", Colors.orange)
];

class Data {
  String label;
  Color color;
  Data(this.label, this.color);
}

class _MonthBudgetListState extends State<MonthBudgetList> {
  late BudgetListProvider _budgetListProvider;
  @override
  void initState() {
    super.initState();
  }

  TextStyle detailTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(0xFF, 0x8A, 0x8A, 0x8E));

  @override
  Widget build(BuildContext context) {
    _budgetListProvider = Provider.of<BudgetListProvider>(context);
    return Scaffold(
      appBar: monthbudgetAppbar(),
      body: bodyWidget(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(95, 89, 225, 1),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            addDialog();
          }),
    );
  }

  AppBar monthbudgetAppbar() {
    return AppBar(
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
        ));
  }

  Widget bodyWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Column(
        children: [
          Text(
            '${numberFormat(widget.userInput)}원',
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '${DateTime.now().month}월 예산',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(0xFF, 0x8A, 0x8A, 0x8E),
            ),
          ),
          const SizedBox(height: 30),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _budgetListProvider.selectedBudgetList.length,
              itemBuilder: (context, index) => budgetItem(index)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(
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
                      (route) => false),
                  child: Row(
                    children: const [
                      Text('건너뛰기',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Icon(
                        Icons.arrow_forward_sharp,
                        size: 15,
                      )
                    ],
                  ),
                ),
                InkWell(
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
                  },
                  child: Container(
                      child: Row(
                    children: const [
                      Text('저장', style: TextStyle(fontWeight: FontWeight.w600)),
                      Icon(
                        Icons.check,
                        size: 15,
                      )
                    ],
                  )),
                ),
              ])
        ],
      ),
    );
  }

  Widget budgetItem(int index) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _budgetListProvider.selectedBudgetList[index].category,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        '${numberFormat(_budgetListProvider.selectedBudgetList[index].price)}원',
                        style: detailTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editDialog(index);
                      },
                    ),
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteDialog(index);
                      },
                    )
                  ],
                ),
              ],
            )),
        const Divider(
          thickness: 0.8,
        )
      ],
    );
  }

  void addDialog() {
    String price = '';
    Data selected = _choiceChipsList[0];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, stfSetState) => AlertDialog(
                    buttonPadding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          cursorColor: selected.color,
                          autofocus: true,
                          onChanged: (value) {
                            price = value;
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            suffixText: '원',
                            label: ChoiceChip(
                                selectedColor: selected.color,
                                disabledColor: selected.color,
                                label: Text(selected.label),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                selected: false),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: selected.color,
                                  width: 3,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: selected.color,
                                  width: 3,
                                )),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          direction: Axis.horizontal,
                          children: _choiceChipsList
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 5),
                                    child: ChoiceChip(
                                      label: Text(e.label),
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      backgroundColor: e.color,
                                      selected: false,
                                      onSelected: (bool value) {
                                        stfSetState(() {
                                          selected = e;
                                        });
                                        _budgetListProvider.setIndex(
                                            _choiceChipsList.indexOf(e));
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    actions: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: Row(
                            children: [
                              Flexible(
                                  child: InkWell(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  alignment: Alignment.center,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(234, 234, 234, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                              )),
                              Flexible(
                                  child: InkWell(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                  alignment: Alignment.center,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(88, 212, 175, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '추가',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  if (price != '') {
                                    _budgetListProvider.addItem(MonthBudgetItem(
                                        price: price,
                                        category: selected.label));
                                  }

                                  Navigator.of(context).pop();
                                },
                              ))
                            ],
                          ))
                    ],
                  ));
        });
  }

  void editDialog(int index) {
    String price = _budgetListProvider.selectedBudgetList[index].price;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            buttonPadding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Text(
              '금액 수정',
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1),
                fontWeight: FontWeight.w700,
                fontSize: 16),
            content: TextField(
              autofocus: true,
              cursorColor: const Color.fromRGBO(88, 212, 175, 1),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              onChanged: (value) {
                price = value;
              },
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(88, 212, 175, 1)),
                  ),
                  suffixText: '원',
                  hintText:
                      _budgetListProvider.selectedBudgetList[index].price),
            ),
            actions: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: Row(
                    children: [
                      Flexible(
                          child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(234, 234, 234, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '취소',
                            style: TextStyle(
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                      )),
                      Flexible(
                          child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(88, 212, 175, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '수정',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          if (price != '') {
                            _budgetListProvider.editItem(
                                index,
                                MonthBudgetItem(
                                    id: _budgetListProvider
                                        .selectedBudgetList[index].id,
                                    price: price,
                                    category: _budgetListProvider
                                        .selectedBudgetList[index].category));
                          }

                          Navigator.of(context).pop();
                        },
                      ))
                    ],
                  ))
            ],
          );
        });
  }

  void deleteDialog(int index) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                '삭제하시겠습니까?',
                style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
                textAlign: TextAlign.center,
              )),
          actions: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: Row(
                  children: [
                    Flexible(
                        child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                        alignment: Alignment.center,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(234, 234, 234, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                    Flexible(
                        child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                        alignment: Alignment.center,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(88, 212, 175, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '삭제',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _budgetListProvider.deleteItem(index);
                      },
                    ))
                  ],
                ))
          ],
        );
      });
}
