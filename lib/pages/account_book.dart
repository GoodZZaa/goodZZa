import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/utills/day_to_weekday.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';

class AccountBook extends StatefulWidget {
  const AccountBook({super.key});

  @override
  State<AccountBook> createState() => _AccountBookState();
}

class _AccountBookState extends State<AccountBook>
    with TickerProviderStateMixin {
  late AccountProvider _accountProvider;
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _accountProvider = Provider.of<AccountProvider>(context, listen: false);
    _accountProvider.initDate();
    _accountProvider.getData();

    _tabController = TabController(
        length: _accountProvider.days.length,
        vsync: this,
        initialIndex: DateTime.now().day - 1);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

    Widget paymentTabView() {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TabBar(
                onTap: (value) {
                  _accountProvider.setDay(value + 1);
                },
                labelPadding: const EdgeInsets.all(5),
                controller: _tabController,
                isScrollable: true,
                tabs: _accountProvider.days
                    .map((element) => Tab(
                        height: 66,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: element ==
                                        _accountProvider.selectedDate
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color:
                                            const Color.fromRGBO(47, 45, 45, 1))
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
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color:
                                              Color.fromRGBO(155, 156, 160, 1)),
                                    ),
                                    Text(
                                      element.day.toString(),
                                      style: element ==
                                              _accountProvider.selectedDate
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
                            Icon(Icons.circle,
                                size: 8,
                                color: _accountProvider.paymentItems
                                        .where((e) => e.date == element)
                                        .toList()
                                        .isEmpty
                                    ? Colors.transparent
                                    : Colors.black45)
                          ],
                        )))
                    .toList(),
                indicator: const BoxDecoration(color: Colors.transparent),
              ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                height: 1,
                width: double.maxFinite,
                color: const Color.fromRGBO(218, 218, 218, 1),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15,
                              ),
                              Text('전체',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600)),
                              Icon(Icons.keyboard_arrow_down_sharp, size: 20)
                            ],
                          ),
                        )),
                    InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    '추가하기',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.add_circle_rounded,
                                    size: 36,
                                    color:
                                        Color.fromARGB(0xFF, 0xD9, 0xD9, 0xD9),
                                  )
                                ])))
                  ],
                ),
              ),
              Container(
                  height: 300,
                  child: TabBarView(
                      controller: _tabController,
                      children: _accountProvider.days
                          .map((e) => paymentListView(_accountProvider
                              .paymentItems
                              .where((element) => element.date == e)
                              .toList()))
                          .toList()))
            ],
          ));
    }

    return Scaffold(
        body: _accountProvider.state == AccountState.success
            ? Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    monthControll(),
                    accountCard(),
                    monthText(),
                    paymentTabView()
                  ],
                ))
            : failMessageWidget());
  }

  void paymentBottomSheet(PaymentItem item) => showModalBottomSheet(
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
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        '${item.price} 원',
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

  Widget paymentListView(List<PaymentItem> items) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => paymentItemCard(items[index])));
  }

  Widget paymentItemCard(PaymentItem item) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 75,
        width: double.infinity,
        child: InkWell(
            onTap: () => paymentBottomSheet(item),
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        left: BorderSide(
                            color: Color.fromRGBO(47, 45, 45, 1), width: 3.5))),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.productName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text('${item.price}원',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right),
                      )
                    ]))));
  }

  Widget monthControll() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
    // 미완성
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          itemBuilder: (context, index) => accountCardItem()),
    );
  }

  Widget accountCardItem() {
    return Container(
      width: 300,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_accountProvider.selectedDate.month}월 총 예산',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text('${_accountProvider.account.max}원',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          Container(
            alignment: Alignment.centerRight,
            child: const Text(
              '남은잔액',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                  '${_accountProvider.account.max - _accountProvider.account.all}원',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right))
        ],
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

  Widget failMessageWidget() {
    switch (_accountProvider.state) {
      case AccountState.loading:
        return const Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
        );
      case AccountState.fail:
        return const Center(
            child:
                Text("원하는 경로가 없어요!\n다시 검색해주세요", textAlign: TextAlign.center));

      default:
        return const Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
        );
    }
  }
}
