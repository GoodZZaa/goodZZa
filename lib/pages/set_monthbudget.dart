import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetMonthBudget extends StatefulWidget {
  const SetMonthBudget({Key? key}) : super(key: key);

  @override
  State<SetMonthBudget> createState() => _SetMonthBudgetState();
}

class _SetMonthBudgetState extends State<SetMonthBudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Container(child: Text("이번 달 예산은 얼마인가요")),
          Container(
            child: Column(
              children: [Text("3000000"), Text("30만원")],
            ),
          ),
          Container(
            child: Text("이번달 하루 생활비 100000원"),
          ),
          Container()
        ],
      ),
    );
  }
}
