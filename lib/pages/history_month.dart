import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/provider/history_month_provider.dart';
import 'package:provider/provider.dart';
import '../models/payments.dart';
import '../provider/account_book_provider.dart';
import 'history_daily.dart';

class HistoryMonth extends StatefulWidget {
  final int year;
  final int month; // 홈 page에서 넘어온 현재의 year 과 month 값 담기
  const HistoryMonth({required this.year, required this.month});

  @override
  State<HistoryMonth> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryMonth> {
  late HistoryMonthProvider _historyMonthProvider;
  /*기존의 accountprovider 대신에 새로 만든 이유:
    account provider에는 가계부 홈 화면에서 '달'마다 값이 달라지는 데이터도 받아오는데
    메인 홈에서는 현재 년과 월만 필요 */
  // late 쓰면 초기화는 나중으로 미룬다.

  @override
  void initState() {
    super.initState();
    _historyMonthProvider =
        Provider.of<HistoryMonthProvider>(context, listen: false);
    // 시작할 때 provider에서 값 가져와 주고
    _historyMonthProvider.getBudgetData(widget.year, widget.month);
    _historyMonthProvider.getPayoutData(widget.year, widget.month);
    // HistoryMonty 실행할 때 가져온 year과 month값을 넣어서 getBudgetData 메소드 실행
  }

  @override
  Widget build(BuildContext context) {
    _historyMonthProvider = Provider.of<HistoryMonthProvider>(context);

    Widget bodyWidget() {
      if (_historyMonthProvider.budgetState == AccountState.success &&
          _historyMonthProvider.payoutState == AccountState.success) {
        return successWidget();
      } else if (_historyMonthProvider.payoutState == AccountState.loading ||
          _historyMonthProvider.budgetState == AccountState.loading) {
        return loadingWidget();
      } else {
        return failWidget();
      }
    }

    return Scaffold(appBar: HistoryTitle(), body: bodyWidget());
  }

  Widget successWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: HistoryList(),
            ),
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
      );

  Widget failWidget() => Center(child: Text('실패'));
  Widget loadingWidget() => CircularProgressIndicator();

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
            Text("${widget.month}월 지출 내역",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ));
  }

  Widget HistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      // 월 장보기 내역 없을 시에 '장보기'와 '예산박스' 사이에 공백이 생기는 거 없애주는 거
      itemCount: _historyMonthProvider.payoutItems.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          _historyMonthProvider.payoutItems[index],
        );
      },
    );
  }

  Widget HistoryCard(PayoutItem payoutItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MarketImage(payoutItem),
        CartMonth(payoutItem),
      ],
    );
  }

  Widget MarketImage(PayoutItem payoutItem) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.network(
          'https://avatars.githubusercontent.com/u/121633919?s=16&v=4',
        ));
  }

  Widget CartMonth(PayoutItem payoutItem) {
    List<dynamic> productItem;
    if (payoutItem.products.length < 2) {
      productItem = payoutItem.products;
    } else {
      productItem = payoutItem.products.sublist(0, 2);
    }
    // productItem 개수가 2개 이하면 error 떠서 추가해준 부분

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
                '${productItem.toString().replaceAll('[', '').replaceAll(']', '')} 등..외 ${payoutItem.products.length}개',
                //replaceAll*
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                )),
            Container(
                alignment: Alignment.centerRight,
                child: Text('${(payoutItem.totalPrice)}원',
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
              Text('${_historyMonthProvider.accountBudget!.totalBalance}원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text(
                  '${_historyMonthProvider.accountBudget!.totalBalance - _historyMonthProvider.accountBudget!.remainingBalance}원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text('${_historyMonthProvider.accountBudget?.remainingBalance}원',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
