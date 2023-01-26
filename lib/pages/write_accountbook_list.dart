import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_zza_code_in_songdo/models/month_budget_item.dart';
import 'package:good_zza_code_in_songdo/pages/write_accountbook.dart';

class WriteAccountbookList extends StatefulWidget {
  /*final String userInput;
  WriteAccountbookList(this.userInput, {Key? key}) : super(key: key);*/

  WriteAccountbookList();

  @override
  State<WriteAccountbookList> createState() => _WriteAccountbookListState();
}

class _WriteAccountbookListState extends State<WriteAccountbookList> {
  // late BudgetListProvider _budgetListProvider;

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
    //_budgetListProvider = Provider.of<BudgetListProvider>(context);
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Write_accountbook(),
              ),
            );
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
            Text("오늘의 기록",
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
          /*Text(
            '${numberFormat(widget.userInput)}원',
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),*/
          const SizedBox(height: 10),
          Text(
            '${DateTime.now().month}월 ${DateTime.now().day}일',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(0xFF, 0x8A, 0x8A, 0x8E),
            ),
          ),
          const SizedBox(height: 30),
          /*  ListView.builder(
              shrinkWrap: true,
              itemCount: _budgetListProvider.selectedBudgetList.length,
              itemBuilder: (context, index) => budgetItem(index)),*/
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
                    /* Text(
                      _budgetListProvider.selectedBudgetList[index].category,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),*/
                    const SizedBox(
                      height: 8,
                    ),
                    /* Text(
                        '${numberFormat(_budgetListProvider.selectedBudgetList[index].price)}원',
                        style: detailTextStyle),*/
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // editDialog(index);
                      },
                    ),
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        //deleteDialog(index);
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
}
