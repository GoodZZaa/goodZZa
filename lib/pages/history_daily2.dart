import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/provider/history_month_provider.dart';
import 'package:provider/provider.dart';
import '../models/payments.dart';
import '../provider/account_book_provider.dart';
import 'history_daily.dart';

class HistoryDaily extends StatefulWidget {
  final int year;
  final int month;
  final int day; // 홈 page에서 넘어온 현재의 year 과 month 값 담기
  const HistoryDaily(
      {required this.year, required this.month, required this.day});

  @override
  State<HistoryDaily> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryDaily> {
  late HistoryMonthProvider _historyMonthProvider;
  ScrollController _controller = ScrollController();

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

    return Scaffold(
        appBar: historyAppbar(),
        backgroundColor: Colors.white,
        body: bodyWidget());
  }

  Widget successWidget() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: historyList(),
          ),
          const Divider(
              height: 1,
              color: Color.fromARGB(128, 193, 193, 193),
              thickness: 0.8),
          const SizedBox(height: 20),
          checkProductNum(),
        ],
      ));

  Widget failWidget() => Center(child: Text('실패'));
  Widget loadingWidget() => Center(child: CircularProgressIndicator());

  AppBar historyAppbar() {
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

        // IconButton(
        //   iconSize: ,
        //     icon: Icon(Icons.arrow_back),
        //     color: Colors.lightBlue,
        //     onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("오늘의 기록",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ],
        ));
  }

  Widget historyList() {
    return Container(
        child: Column(
      children: [
        Text("${widget.month}월 ${widget.day}일",
            style: const TextStyle(
                color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w600)),
        SizedBox(height: 24),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _historyMonthProvider.payoutItems.length,
          itemBuilder: (context, index) {
            return historyCard(
              _historyMonthProvider.payoutItems[index],
            );
          },
        ),
      ],
    ));
  }

  Widget historyCard(PayoutItem payoutItem) {
    return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // marketImage(payoutItem),
              cartMonth(payoutItem),
            ],
          ),
        ));
  }

  Widget marketImage(PayoutItem payoutItem) => Container(
      margin: const EdgeInsets.only(right: 15),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Image.network(payoutItem.imageUrl.toString(), fit: BoxFit.cover));

  Widget cartMonth(PayoutItem payoutItem) {
    List<dynamic> productItem;
    if (payoutItem.products.length < 2) {
      productItem = payoutItem.products;
    } else {
      productItem = payoutItem.products.sublist(0, 1);
    }
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${productItem.toString().replaceAll('[', '').replaceAll(']', '')}',
        style: const TextStyle(
          color: Color.fromARGB(0xFF, 0x22, 0x29, 0x2E),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        alignment: Alignment.centerRight,
        child: Text('${(payoutItem.totalPrice)}원',
            style: const TextStyle(
              color: Color.fromARGB(0xFF, 0x22, 0x29, 0x2E),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right),
      )
    ]));
  }

  Widget checkProductNum() {
    if (_historyMonthProvider.payoutItems.length == 0) {
      return Container(
          alignment: Alignment.center, child: Text('지출내역이 존재하지 않습니다'));
    } else {
      return budgetCard();
    }
  }

  Widget budgetCard() {
    TextStyle plainTextStyle = const TextStyle(
      fontSize: 16,
      color: Color.fromARGB(0xFF, 0x8A, 0x8A, 0x8E),
      fontWeight: FontWeight.w400,
    );
    TextStyle dataTextStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16);
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('한달 예산', style: plainTextStyle),
              Text('${_historyMonthProvider.accountBudget!.totalBalance}원',
                  style: dataTextStyle),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('현재 사용예산', style: plainTextStyle),
              Text(
                  '${_historyMonthProvider.accountBudget!.totalBalance - _historyMonthProvider.accountBudget!.remainingBalance}원',
                  style: dataTextStyle)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('남은 예산', style: plainTextStyle),
              Text('${_historyMonthProvider.accountBudget?.remainingBalance}원',
                  style: dataTextStyle),
            ],
          )
        ],
      ),
    );
  }
}
