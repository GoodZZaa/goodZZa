import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/pages/home_search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                  width: 20,
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
                          "서울시 종로구 삼성동 1번길",
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
                Icon(
                  Icons.shopping_cart,
                  size: 28,
                  color: Color.fromRGBO(200, 200, 203, 1),
                )
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeSearchPage()));
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
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [SaleCard()],
                )),
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
}

Widget SaleCard() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: Expanded(
            child: Image.network(
                'http://image.officedepot.co.kr/item/826740/contents/1508-%EB%AC%B6%EC%9D%8C%EC%83%81%ED%92%88_%EB%B0%B0%EB%84%88.jpg')),
        width: 298,
        height: 144,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      )
    ],
  );
}

Widget RecommendCard() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        child: Expanded(
            child: Image.network(
                'https://cdn.igimpo.com/news/photo/201907/53788_36471_1851.jpg')),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      Container(
        child: Expanded(
            child: Image.network(
                'https://mblogthumb-phinf.pstatic.net/MjAxOTEwMDZfNjEg/MDAxNTcwMzQzOTY0MzY5.Y3gkY-QhrdZlgAhU4zOA-bfLqDBBxI9nF0Op1ueXkcog.zPrycRWb9ttz16KsiqcRt1JW46TogM58W0b7dZJBQBsg.JPEG.sinbuma/IMG_8920.jpg?type=w800')),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      Container(
        child: Expanded(
            child: Image.network(
                'https://martmonster.com/files/attach/images/208/392/003/c1f0d891ddecac6df384622df20bd7cf.jpg')),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      Container(
        child: Expanded(
            child: Image.network(
                'http://www.e2news.com/news/photo/201803/107184_57299_1229.jpg')),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      Container(
        child: Expanded(
            child: Image.network(
                'https://mblogthumb-phinf.pstatic.net/MjAxOTExMThfMjc0/MDAxNTc0MDQ1NzQwMzAx.d9uqBUv7uHUlmxYAVJ6gkP6TBWF2DR6hT14GW8Fb1R8g.BHlpx0vFJUuJUiMcAGvopmyh0ukV71jqYlT3-PeDaVMg.JPEG.kkang6002/20191116_165144.jpg?type=w800')),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
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
                  child: Image.network(
                      'https://recipe1.ezmember.co.kr/cache/recipe/2019/01/03/6b7f6dc09df57b1f46c4e87bf81e200b1.jpg')),
              color: Color.fromRGBO(147, 147, 147, 1),
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding:
                  EdgeInsets.only(left: 13, top: 13, right: 13, bottom: 13),
              color: Color.fromRGBO(200, 200, 203, 1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent product",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "5,800원",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        color: Color.fromRGBO(147, 147, 147, 1),
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
