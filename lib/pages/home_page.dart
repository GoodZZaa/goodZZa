import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/pages/home_search_page.dart';
import 'package:good_zza_code_in_songdo/pages/shoppingcart.dart';
import 'package:good_zza_code_in_songdo/provider/history_month_provider.dart';
import 'package:good_zza_code_in_songdo/provider/home_provider.dart';
import 'package:good_zza_code_in_songdo/provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../provider/account_book_provider.dart';
import 'history_month.dart';
import 'package:good_zza_code_in_songdo/pages/shoppingcart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  late AccountProvider _accountProvider;
  late HomeProvider _homeProvider;
  late TabController _tabController;

  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialLoadStatus: LoadStatus.idle);

  int checkcount = 0;

  void onRefresh() {
    _homeProvider.pageNumber = 1;
    _homeProvider.cheapestproduct.clear();

    _homeProvider.readCheapestProduct().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    if (_homeProvider.cheapestproduct.length < _homeProvider.totalCount) {
      _homeProvider.readCheapestProduct().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
      });
    } else {
      refreshController.loadNoData();
    }
  }

  @override
  void initState() {
    super.initState();

    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.init();

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

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
                width: 60,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "????????? ?????????\n1.5km ??????",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 60,
                child: IconButton(
                  icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.shopping_cart,
                          size: 28,
                          color: Color.fromRGBO(200, 200, 203, 1),
                        ),
                      ]),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShoppingCart(),
                    ));
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 5),
            width: double.infinity,
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => SearchProvider(),
                                  child: const HomeSearchPage(),
                                )));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(147, 147, 147, 1),
                      ),
                      label: const Text(
                        "????????? ??????????????????.                                                             "
                        "                                                      ",
                        style:
                            TextStyle(color: Color.fromRGBO(200, 200, 203, 1)),
                      ),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: NestedScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: false,
                      forceElevated: innerBoxIsScrolled,
                      expandedHeight: 290.0,
                      // appbar ??????
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(child: headerWidget()),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                  ];
                },
                body: lowPriceProduct()),
          )
        ],
      ),
    ));
  }

  Widget headerWidget() {
    return Column(
      children: [
        saleCard(),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              '????????? ?????? ??????',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '1.5km',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(child: Recommandcard()),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                child: Text(
                  '?????? ????????? ??????',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(200, 200, 203, 1)),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    children: const [
                      Text(
                        'Filters',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.filter_list_alt,
                        size: 12,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget saleCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              final now = DateTime.now();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => HistoryMonthProvider(),
                        child: HistoryMonth(
                            year: now.year, month: now.month, day: now.day),
                      )));
            },
            child: Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/img_main_frame.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_accountProvider.selectedDate.month}??? ??? ??????',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                      '${_accountProvider.accountBudget?.totalBalance ?? '-'}???',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      '????????????',
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
                          '${_accountProvider.accountBudget?.remainingBalance ?? '-'}???',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right))
                ],
              ),
              //child: Expanded(
              //child: Image.asset('assets/images/img_main_frame.png')),
            ),
          ),
        )
      ],
    );
  }

  Widget Recommandcard() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _homeProvider.cheapestmart.length,
        itemBuilder: (BuildContext context, int index) {
          return _homeProvider.isLoading2
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  width: 90,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.network(
                            _homeProvider.cheapestmart[index].imageUrl
                                .toString(),
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                );
        });
  }

  /*Widget recommendCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/daon_sikjajae_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hanaro_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/jangbogo_sikjajae_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lotte_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/neo_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ],
    );
  } */

  Widget lowPriceProduct() {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return SmartRefresher(
        enablePullUp: true,
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: _homeProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 15),
                physics: const BouncingScrollPhysics(),
                itemCount: _homeProvider.cheapestproduct.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromARGB(136, 101, 101, 101),
                          blurRadius: 25.0,
                          spreadRadius: -30.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 123,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              image: DecorationImage(
                                image: NetworkImage(_homeProvider
                                    .cheapestproduct[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 13, top: 13, right: 13, bottom: 13),
                          width: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _homeProvider
                                    .cheapestproduct[index].productName,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                '${_homeProvider.cheapestproduct[index].price}???',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  color: Colors.white,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                          onPressed: () {
                                            checkcount++;
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      95, 89, 225, 100)),
                                          child: const Text(
                                            "          Add to cart          ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ))))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
      );
    });
  }
}
