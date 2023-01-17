import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_zza_code_in_songdo/models/payments.dart';
import 'package:good_zza_code_in_songdo/provider/history_month_provider.dart';
import 'package:good_zza_code_in_songdo/utills/day_to_weekday.dart';
import 'package:good_zza_code_in_songdo/pages/home_search_page.dart';
import 'package:good_zza_code_in_songdo/provider/search_provider.dart';
import 'package:provider/provider.dart';
import '../provider/account_book_provider.dart';
import 'history_month.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 40,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "서울시 종로구",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Text(
                      "1.5km 이내",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Container(
                  width: 60,
                  child: IconButton(
                    icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 28,
                            color: Color.fromRGBO(200, 200, 203, 1),
                          ),
                        ]),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Container(
              width: 390,
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
                        icon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(147, 147, 147, 1),
                        ),
                        label: Text(
                          "물건을 검색해보세요.                                                             "
                          "                                                      ",
                          style: TextStyle(
                              color: Color.fromRGBO(200, 200, 203, 1)),
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(
              width: 5,
              height: 10,
            ),
            Container(width: 390, height: 144, child: SaleCard()),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '최저가 마트 추천',
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
                )),
            SizedBox(
              height: 10,
            ),
            RecommendCard(),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 390,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    child: Text(
                      '현재 최저가 상품',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(200, 200, 203, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        children: [
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
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    LowPriceProduct(),
                    Expanded(child: SizedBox()),
                    LowPriceProduct(),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    LowPriceProduct(),
                    Expanded(child: SizedBox()),
                    LowPriceProduct(),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    LowPriceProduct(),
                    Expanded(child: SizedBox()),
                    LowPriceProduct(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget SaleCard() {
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
                        child: HistoryMonth(year: now.year, month: now.month),
                      )));

              /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => AccountProvider(),
                    child: const HistoryMonth(),
                  )));*/
            },
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/img_main_frame.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: Column(
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
                //child: Expanded(
                //child: Image.asset('assets/images/img_main_frame.png')),

                height: 144,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget RecommendCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              image: const DecorationImage(
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
              image: const DecorationImage(
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
              image: const DecorationImage(
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
              image: const DecorationImage(
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
              image: const DecorationImage(
                image: AssetImage('assets/images/neo_mart.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ],
    );
  }

  Widget LowPriceProduct() {
    return Container(
      width: 180,
      height: 260,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Expanded(
                    child: Image(
                  image: AssetImage('assets/images/apple.png'),
                  fit: BoxFit.fill,
                  //'https://recipe1.ezmember.co.kr/cache/recipe/2019/01/03/6b7f6dc09df57b1f46c4e87bf81e200b1.jpg'),
                )),
                color: Colors.white,
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding:
                    EdgeInsets.only(left: 13, top: 13, right: 13, bottom: 13),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "세상에서 제일 맛있는 사과 5KG",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "16,000원",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          color: Colors.white,
                          child: Align(
                              alignment: Alignment.center,
                              child: Expanded(
                                child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromRGBO(147, 147, 147, 1)),
                                    child: Text(
                                      "          Add to cart          ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                              )))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
