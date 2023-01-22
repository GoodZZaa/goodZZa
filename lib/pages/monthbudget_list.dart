import 'package:flutter/material.dart';
import '../models/monthbudget_list_arguments.dart';
import '../models/monthbudget_list_model.dart';
import '../provider/monthbudgetList_provider.dart';
import 'monthbudget_addingCategories.dart';

class Monthbudget_List extends StatefulWidget {
  final String userInput;
  Monthbudget_List(this.userInput, {Key? key}) : super(key: key);

  @override
  State<Monthbudget_List> createState() => _Monthbudget_List_State();
}

class Data {
  String label;
  Color color;
  Data(this.label, this.color);
}

class _Monthbudget_List_State extends State<Monthbudget_List> {
  List<MonthbudgetList> monthbudgetList = [];
  bool isLoading = true;
  MonthbudgetListDefault monthbudgetListDefault = MonthbudgetListDefault();

  int? _selectedIndex;

  final List<Data> _choiceChipsList = [
    Data("식료품", Colors.lightBlueAccent),
    Data("교통비", Colors.amberAccent),
    Data("생필품", Colors.lime),
    Data("취미", Colors.cyan),
    Data("기타", Colors.orange)
  ];

  @override
  void initState() {
    super.initState();
    monthbudgetList = monthbudgetListDefault.getmonthbudgetList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: monthbudget_list_title(), body: bodyWidget());
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(_choiceChipsList[i].label),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: _choiceChipsList[i].color,
          selected: _selectedIndex == i,
          selectedColor: Color.fromRGBO(95, 89, 225, 1),
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  AppBar monthbudget_list_title() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.deepPurpleAccent,
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  Widget bodyWidget() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            // backgroundColor: Colors.deepPurpleAccent,
            backgroundColor: Color.fromRGBO(95, 89, 225, 1),
            child: Text('+', style: TextStyle(fontSize: 25)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String price = '';
                    String category = '';
                    return AlertDialog(
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                price = value;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '금액'),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              direction: Axis.horizontal,
                              children: choiceChips(),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                monthbudgetListDefault.addMonthbudgetList(
                                  MonthbudgetList(
                                      price: price, category: category),
                                );
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('추가')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('취소')),
                      ],
                    );
                  });
            }),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                        child: Text(
                      DateTime.now().month.toString() +
                          '월' +
                          DateTime.now().day.toString() +
                          '일',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 25),
                    Container(
                        child: Text(
                      widget.userInput + '원',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              monthbudgetList[index].category,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              monthbudgetList[index].price + '원',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                            trailing: Container(
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      child: Icon(Icons.edit),
                                      onTap: () {},
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      child: Icon(Icons.delete),
                                      onTap: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: monthbudgetList.length),
              ),
            ],
          ),
        ));
  }
}
