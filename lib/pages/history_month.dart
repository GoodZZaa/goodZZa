import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payments.dart';
import '../provider/account_book_provider.dart';
import 'history_daily.dart';

class HistoryMonth extends StatefulWidget {
  const HistoryMonth({Key? key}) : super(key: key);

  @override
  State<HistoryMonth> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryMonth> {
  late AccountProvider _accountProvider; //account provider 객체 생성

  @override //이거 있고 없고 실행시 무슨 차이?
  void initState() {
    super.initState();
    _accountProvider = Provider.of<AccountProvider>(context, listen: false);
    //객체 초기화(초기화란? 만든 저장소를 사용할 수 있게 초기값을 넣어주는 것)
    _accountProvider.init(); // 서버에 저장된 값을 불러와주는 메서드를 시작시마다 불러오도록
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context); // 왜 한번 더 쓰지..?

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
            BudgetCard()
            //Budgets(),
          ],
        ),
      ),
    );
  }

  AppBar HistoryTitle() {
    return AppBar(
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
            Text("${_accountProvider.selectedDate.month}월 지출 내역",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ));
  }

  Widget HistoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _accountProvider.payoutItems.length,
        itemBuilder: (context, index) {
          return HistoryCard(
            payoutItem: _accountProvider.payoutItems[index],
          );
        },
      ),
    );
  }

  Widget HistoryCard({required PayoutItem payoutItem}) {
    // 왜 required 필요?
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MarketImage(payoutItem),
        CartMonth(payoutItem),
      ],
    );
  }

  Widget MarketImage(PayoutItem payoutItem) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset("assets/images/hanaro_mart.jpeg"),
    );
  }

  Widget CartMonth(PayoutItem payoutItem) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    create: (context) => AccountProvider(),
                    child: const HistoryDaily(),
                  )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${payoutItem.date.month}월 ${payoutItem.date.day}일 장보기',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                '${payoutItem.products.sublist(0, 2)} 등..외 ${payoutItem.products.length}개',
                //sublist하면 [] 왜 생기지?
                //문제는 2개 이상이 없으면 에러 뜬다..
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
      ),
    );
  }

  Widget BudgetCard() {
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
              Text(
                  '${_accountProvider.accountBudget!.totalBalance - _accountProvider.accountBudget!.remainingBalance}원',
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
