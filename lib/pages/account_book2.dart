import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/pages/set_monthbudget.dart';
import 'package:good_zza_code_in_songdo/pages/write_accountbook.dart';
import 'package:good_zza_code_in_songdo/utills/day_to_weekday.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';
import '../provider/history_month_provider.dart';
import 'history_month.dart';

class AccountBook2 extends StatefulWidget {
  const AccountBook2({super.key});

  @override
  State<AccountBook2> createState() => _AccountBookState();
}

class _AccountBookState extends State<AccountBook2>
    with TickerProviderStateMixin {
  late AccountProvider _accountProvider;
  late TabController _tabController;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _accountProvider = Provider.of<AccountProvider>(context, listen: false);
    _accountProvider.init();

    _tabController = TabController(
        length: _accountProvider.days.length,
        vsync: this,
        initialIndex: DateTime.now().day - 1);

    _tabController.addListener(() {
      setState(() {
        _accountProvider.setDay(_tabController.index + 1);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

    // if (_accountProvider.budgetState == AccountState.fail) {
    //   _accountProvider.getBudgetData();
    // }
    // if (_accountProvider.payoutState == AccountState.fail) {
    //   _accountProvider.getPayoutData();
    // }

    if (_accountProvider.budgetState == AccountState.success &&
        _accountProvider.payoutState == AccountState.success) {
      return successWidget();
    } else if (_accountProvider.budgetState == AccountState.fail &&
        _accountProvider.payoutState == AccountState.fail) {
      return failWidget();
    } else {
      return loadingWidget();
    }
  }

  Widget successWidget() => Scaffold(
      body: NestedScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: false,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 250.0, // appbar 크기
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          monthControl(),
                          accountCard(),
                        ]),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: AccountBookHeaderDelegate(_tabController)),
              ),
            ];
          },
          body: paymentTabView()));

  Widget loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget failWidget() => const Center(
        child: Text('데이터를 불러오는데에 실패하였습니다'),
      );

  Widget paymentTabView() {
    var idx = 1;
    return TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: _accountProvider.days
            .map((e) => AccountTabScreen(
                _accountProvider.payoutState,
                _accountProvider.payoutItems
                    .where(
                      (element) => element.date == e,
                    )
                    .toList(),
                key: ValueKey(idx++)))
            .toList());
  }

  Widget monthControl() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          IconButton(
              iconSize: 15,
              onPressed: () {
                _accountProvider.setMonthBefore();
                _tabController = TabController(
                    length: _accountProvider.days.length, vsync: this);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              )),
          Text(
            "${_accountProvider.selectedDate.month}월",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          IconButton(
              iconSize: 15,
              onPressed: () {
                _accountProvider.setMonthNext();
                _tabController = TabController(
                    length: _accountProvider.days.length, vsync: this);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
              )),
        ],
      ),
    );
  }

  Widget accountCard() {
    return GestureDetector(
      onTap: () {
        // /* Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ChangeNotifierProvider(
        //           create: (context) => AccountProvider(),
        //           child: HistoryMonth(),
        //         )));*/

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Write_accountbook(),
          ),
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
              image: AssetImage('assets/images/img_main_frame.png'),
              fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: _accountProvider.budgetState == AccountState.fail
            ? const Center(
                child: Text('내 예산을 불러오는데 실패했어요'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_accountProvider.selectedDate.month}월 총 예산',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                      '${_accountProvider.accountBudget?.totalBalance ?? '-'}원',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      '남은잔액',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                          '${_accountProvider.accountBudget?.remainingBalance ?? '-'}원',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right))
                ],
              ),
      ),
    );
  }

  Widget monthText() {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 1,
            width: double.maxFinite,
            color: const Color.fromRGBO(218, 218, 218, 1),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${_accountProvider.selectedDate.month}월',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(57, 63, 66, 1),
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 25,
              ),
              const Text('지출내역',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(0xFF, 0x36, 0x39, 0x42),
                      fontWeight: FontWeight.w700))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: 1,
            width: double.maxFinite,
            color: const Color.fromRGBO(218, 218, 218, 1),
          )
        ],
      ),
    );
  }
}

class AccountBookHeaderDelegate extends SliverPersistentHeaderDelegate {
  AccountBookHeaderDelegate(TabController tabController) {
    _tabController = tabController;
  }

  late TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var _accountProvider = Provider.of<AccountProvider>(context);

    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
      return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 1,
              width: double.maxFinite,
              color: const Color.fromRGBO(218, 218, 218, 1),
              margin: const EdgeInsets.only(bottom: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${accountProvider.selectedDate.month}월',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(57, 63, 66, 1),
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 25,
                ),
                const Text('지출내역',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(0xFF, 0x36, 0x39, 0x42),
                        fontWeight: FontWeight.w700))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 13, bottom: 10),
              height: 1,
              width: double.maxFinite,
              color: const Color.fromRGBO(218, 218, 218, 1),
            ),
            TabBar(
              onTap: (value) {
                accountProvider.setDay(value + 1);
              },
              labelPadding: const EdgeInsets.all(5),
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              isScrollable: true,
              tabs: accountProvider.days
                  .map((element) => Tab(
                      height: 66,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: element ==
                                      accountProvider.selectedDate
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color:
                                          const Color.fromRGBO(88, 212, 175, 1))
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1)),
                              alignment: Alignment.center,
                              height: 50,
                              width: 45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    dayToWeekday(element.weekday),
                                    style:
                                        element == accountProvider.selectedDate
                                            ? const TextStyle(
                                                fontSize: 10,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.7))
                                            : const TextStyle(
                                                fontSize: 10,
                                                color: Color.fromRGBO(
                                                    155, 156, 160, 1)),
                                  ),
                                  Text(
                                    element.day.toString(),
                                    style:
                                        element == accountProvider.selectedDate
                                            ? const TextStyle(
                                                color: Color.fromRGBO(
                                                    248, 247, 255, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              )
                                            : const TextStyle(
                                                color: Color.fromARGB(
                                                    0xFF, 0x36, 0x39, 0x42),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                  )
                                ],
                              )),
                          Container(
                              padding: const EdgeInsets.only(top: 3),
                              child: Icon(Icons.circle,
                                  size: 8,
                                  color: accountProvider.payoutItems
                                          .where((e) => e.date == element)
                                          .toList()
                                          .isEmpty
                                      ? Colors.transparent
                                      : const Color.fromRGBO(95, 89, 225, 1)))
                        ],
                      )))
                  .toList(),
              indicator: const BoxDecoration(color: Colors.transparent),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              height: 1,
              width: double.maxFinite,
              color: const Color.fromRGBO(218, 218, 218, 1),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => HistoryMonthProvider(),
                                  child: HistoryMonth(
                                    year: _accountProvider.selectedDate.year,
                                    month: _accountProvider.selectedDate.month,
                                    day: _accountProvider.selectedDate.day,
                                  ),
                                  //지금 현재 년도와 월을 넘겨준다.
                                )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('전체보기',
                                style: TextStyle(
                                    color: Color.fromRGBO(57, 63, 66, 1),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.menu,
                              size: 20,
                              color: Color.fromRGBO(57, 63, 66, 1),
                            )
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Write_accountbook(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('추가하기',
                                style: TextStyle(
                                    color: Color.fromRGBO(57, 63, 66, 1),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add,
                              size: 20,
                              color: Color.fromRGBO(57, 63, 66, 1),
                            )
                          ],
                        ),
                      )),
                  // InkWell(
                  //     child: Container(
                  //         padding: const EdgeInsets.all(3),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               const Text(
                  //                 '추가하기',
                  //                 style: TextStyle(
                  //                     fontSize: 13,
                  //                     fontWeight: FontWeight.w500),
                  //               ),
                  //               const SizedBox(
                  //                 width: 8,
                  //               ),
                  //               Image.asset(
                  //                 'assets/icons/icon_plus.png',
                  //                 height: 26,
                  //                 width: 26,
                  //               )
                  //             ])))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  double get maxExtent => 220;

  @override
  double get minExtent => 220;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AccountTabScreen extends StatefulWidget {
  late final List<PayoutItem> _list;
  late AccountState _state;

  AccountTabScreen(AccountState state, List<PayoutItem>? list, {Key? key})
      : super(key: key) {
    _list = list!;
    _state = state;
  }

  @override
  State<AccountTabScreen> createState() => _AccountTabScreenState();
}

class _AccountTabScreenState extends State<AccountTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget._state == AccountState.fail
        ? const Text('지출내역을 불러오는데 실패했어요')
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 220),
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: ScrollController(),
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  paymentItemCard(widget._list[index]),
                              childCount: widget._list.length))
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget paymentItemCard(PayoutItem item) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
            onTap: () => paymentBottomSheet(item),
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color.fromARGB(255, 175, 175, 175))
                    ],
                    border: Border(
                        left: BorderSide(
                            color: Color.fromRGBO(95, 89, 225, 1),
                            width: 3.5))),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.products
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.market,
                        style: const TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(97, 96, 96, 1)),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text('${item.totalPrice}원',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right),
                      )
                    ]))));
  }

  void paymentBottomSheet(PayoutItem item) => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      context: context,
      builder: (BuildContext context) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        item.products
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${item.totalPrice} 원',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('yyyy년 MM월 dd일').format(item.date),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ))
            ],
          ));

  @override
  bool get wantKeepAlive => true;
}
