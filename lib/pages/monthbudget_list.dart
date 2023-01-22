import 'package:flutter/material.dart';
import '../models/monthbudget_list_arguments.dart';
import '../models/monthbudget_list_model.dart';
import '../provider/monthbudgetList_provider.dart';
import 'monthbudget_addingCategories.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
          onPressed: () {},
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                        child: Text(
                      '1월 22일',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 25),
                    Container(child: Text('25000원')),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
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
