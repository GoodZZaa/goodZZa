import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/utills/number_format.dart';
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

  TextStyle detailTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(0xFF, 0x8A, 0x8A, 0x8E));

  @override
  Widget build(BuildContext context) {
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
          selectedColor: const Color.fromRGBO(95, 89, 225, 1),
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
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
          Container(
              margin: const EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * 0.7,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: monthbudgetList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          monthbudgetList[index].category,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text('${monthbudgetList[index].price}원',
                                            style: detailTextStyle),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          iconSize: 25,
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          iconSize: 25,
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {},
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
                      })),
        ],
      ),
    );
  }

  void addDialog() => showDialog(
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: '금액'),
                ),
                const SizedBox(height: 8),
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
                      MonthbudgetList(price: price, category: category),
                    );
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('추가')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('취소')),
          ],
        );
      });
}
