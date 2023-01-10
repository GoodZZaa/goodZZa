import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payments.dart';
import '../provider/account_book_provider.dart';

class HistoryMonth extends StatefulWidget {
  const HistoryMonth({Key? key}) : super(key: key);

  @override
  State<HistoryMonth> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryMonth> {
  late AccountProvider _accountProvider;

  void initState() {
    super.initState();
    _accountProvider = Provider.of<AccountProvider>(context, listen: false);
    _accountProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

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
            Text("${_accountProvider.selectedDate.month}월 지출 내역",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ));
  }
  Widget HistoryList() {
    // 리스트빌더로 HistoryCard 를 만든다.
    // var historyList = _accountProvider.payoutItems;
    var historyList = [
      PayoutItem(date: "1월1일", products: ["가지", "복숭아"], totalPrice: 1000, market: "우리마켓"),
      PayoutItem(date: "1월2일", products: ["가지", "복숭아"], totalPrice: 1000, market: "우리마켓2"),
      PayoutItem(date: "1월3일", products: ["가지", "복숭아"], totalPrice: 1000, market: "우리마켓3"),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          return HistoryCard(
            payoutItem: historyList[index],
          );
        },
      ),
    );
  }

  Widget HistoryCard({required PayoutItem payoutItem}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _MarketImage(payoutItem),
        _CartMonth(payoutItem),
      ],
    );
  }

  Widget _MarketImage(PayoutItem payoutItem) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset("assets/images/good_zza.png"),
    );
  }

  Widget _CartMonth(PayoutItem payoutItem) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${payoutItem.date} 장보기',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
              // 컬렉션
              '${payoutItem.products.toString()} 등..외 ${payoutItem.products.length}개',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              )),
          Container(
              alignment: Alignment.centerRight,
              child: Text('${payoutItem.totalPrice}원',
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
              //
              Text('현재 사용예산', style: TextStyle(color: Colors.grey)),
              Text('남은 예산', style: TextStyle(color: Colors.grey)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${_accountProvider.accountBudget?.totalBalance}원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text('20000원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text('${_accountProvider.accountBudget?.remainingBalance}원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
