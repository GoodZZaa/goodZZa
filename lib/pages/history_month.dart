import 'package:flutter/material.dart';

class HistoryMonth extends StatefulWidget {
  const HistoryMonth({Key? key}) : super(key: key);

  @override
  State<HistoryMonth> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryMonth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HistoryTitle(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HistoryList(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 1,
              width: double.maxFinite,
              color: const Color.fromRGBO(218, 218, 218, 1),
            ),
            SizedBox(height: 20),
            BudgetList(),
            //Budgets(),
          ],
        ),
      ),
    );
  }

  AppBar HistoryTitle() {
    return AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_sharp, color: Colors.lightBlue),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("월 지출 내역",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ));
  }
}

Widget HistoryList() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _MarketImage(),
      _CartMonth(),
    ],
  );
}

Widget _MarketImage() {
  return SizedBox(
    width: 100,
    height: 100,
    child: Image.asset("assets/images/good_zza.png"),
  );
}

Widget _CartMonth() {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '1월 24일 장보기',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('햇반,파,주스 등..외 5개',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            )),
        Container(
            alignment: Alignment.centerRight,
            child: Text('7500원',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right)),
      ],
    ),
  );
}

Widget BudgetList() {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('한달 예산', style: TextStyle(color: Colors.grey)),
            Text('현재 사용예산', style: TextStyle(color: Colors.grey)),
            Text('남은 예산', style: TextStyle(color: Colors.grey)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('150000원',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text('20000원',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text('130000원',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
  );
}
