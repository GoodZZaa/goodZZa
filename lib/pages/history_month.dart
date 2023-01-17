import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/provider/history_month_provider.dart';
import 'package:provider/provider.dart';
import '../models/payments.dart';
import '../provider/account_book_provider.dart';
import 'history_daily.dart';

class HistoryMonth extends StatefulWidget {
  final int year;
  final int month;
  const HistoryMonth({required this.year, required this.month});

  @override
  State<HistoryMonth> createState() => _HistoryMonthState();
}

class _HistoryMonthState extends State<HistoryMonth> {
  late HistoryMonthProvider _historyMonthProvider;

  @override //이거 있고 없고 실행시 무슨 차이?
  void initState() {
    super.initState();
    // _accountProvider = Provider.of<AccountProvider>(context, listen: false);
    // _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    // //객체 초기화(초기화란? 만든 저장소를 사용할 수 있게 초기값을 넣어주는 것)
    // _accountProvider.init(); // 서버에 저장된 값을 불러와주는 메서드를 시작시마다 불러오도록
    _historyMonthProvider =
        Provider.of<HistoryMonthProvider>(context, listen: false);

    _historyMonthProvider.getBudgetData(widget.year, widget.month);
    _historyMonthProvider.getPayoutData(widget.year, widget.month);
  }

  @override
  Widget build(BuildContext context) {
    // _accountProvider = Provider.of<AccountProvider>(context); // 왜 한번 더 쓰지..?
    // _searchProvider = Provider.of<SearchProvider>(context);
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
      itemCount: _historyMonthProvider.payoutItems.length,
      itemBuilder: (context, index) {
        return HistoryCard(
          _historyMonthProvider.payoutItems[index],
        );
      },
    );
  }

  Widget HistoryCard(PayoutItem payoutItem) {
    // 왜 required 필요?
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MarketImage(payoutItem),
        CartMonth(payoutItem),
      ],
    );
  }

  /*Widget MarketImage(PayoutItem payoutItem) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(''),
    );
  }
*/
  Widget MarketImage(PayoutItem payoutItem) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.network(
          'https://avatars.githubusercontent.com/u/121633919?s=16&v=4',
        )
        // CachedNetworkImage(
        //   imageBuilder: (context, imageProvider) => Container(
        //     margin: const EdgeInsets.all(10),
        //     width: 100,
        //     height: 70,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //       // shape: BoxShape.circle,
        //       image:
        //           DecorationImage(image: imageProvider, fit: BoxFit.cover),
        //     ),
        //   ),
        //   imageUrl:
        //       'https://www.thejungleadventure.com/assets/images/noimage/noimage.png',
        //   /*progressIndicatorBuilder: (context, url, downloadProgress) =>
        //       Container(
        //     width: 100,
        //     height: 70,
        //     child:
        //         CircularProgressIndicator(value: downloadProgress.progress),
        //   ),
        //   errorWidget: (context, url, error) => Icon(Icons.error),*/
        // );

        );
  }

  Widget CartMonth(PayoutItem payoutItem) {
    List<dynamic> productItem;
    if (payoutItem.products.length < 2) {
      productItem = payoutItem.products;
    } else {
      productItem = payoutItem.products.sublist(0, 2);
    }
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
