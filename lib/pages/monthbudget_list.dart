import 'package:flutter/material.dart';
import '../models/monthbudget_list_arguments.dart';
import '../models/monthbudget_list_model.dart';
import '../provider/monthbudgetList_provider.dart';
import 'monthbudget_addingCategories.dart';

class Monthbudget_List extends StatefulWidget {
  final String userInput;
  Monthbudget_List(this.userInput, {Key? key}) : super(key: key);

  @override
  State<Monthbudget_List> createState() => _TodoListState();
}

class _TodoListState extends State<Monthbudget_List> {
  List<MonthbudgetList> monthbudgetList = [];
  bool isLoading = true;
  MonthbudgetListDefault monthbudgetListDefault = MonthbudgetListDefault();

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
            backgroundColor: Colors.deepPurpleAccent,
            child: Text('+', style: TextStyle(fontSize: 25)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String title = '';
                    String description = '';
                    return AlertDialog(
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '금액'),
                            ),
                            SizedBox(height: 8),
                            /*TextField(
                              onChanged: (value) {
                                description = value;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '설명'),
                            )*/
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                monthbudgetListDefault.addMonthbudgetList(
                                  MonthbudgetList(
                                      title: title, description: description),
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
                            title: Text(monthbudgetList[index].title),
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
