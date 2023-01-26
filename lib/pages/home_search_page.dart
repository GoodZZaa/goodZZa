import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_zza_code_in_songdo/models/mart_product.dart';
import 'package:good_zza_code_in_songdo/pages/recommend_result_page.dart';
import 'package:good_zza_code_in_songdo/provider/recommend_result_provider.dart';
import 'package:good_zza_code_in_songdo/provider/search_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPage();
}

class _HomeSearchPage extends State<HomeSearchPage> {
  late SearchProvider _searchProvider;
  late Box<List<String>> searchHistory;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchHistory = Hive.box('searchHistory');
    if (searchHistory.isEmpty) {
      searchHistory.put(0, []);
    }

    _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _renderListView() {
    _searchProvider = Provider.of<SearchProvider>(context);
    final products = _searchProvider.products;
    final loading = _searchProvider.isLoading;

    if (loading && products.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!loading && products.length == 0) {
      List<String>? list = searchHistory.get(0);

      List<Widget> searchHistoryWidgets = list == null
          ? []
          : list.reversed
              .map(
                (word) => Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: ListTile(
                    leading: Text("$word"),
                    onTap: () async {
                      await _searchProvider.search(word);
                      List<String>? list = searchHistory.get(0);

                      if (list!.contains(word)) {
                        list.remove(word);
                        searchHistory.put(0, [...list, word]);
                      } else if (list.length < 5) {
                        searchHistory.put(0, [...list, word]);
                      } else {
                        list.removeAt(0);
                        searchHistory.put(0, [...list, word]);
                      }
                      _textEditingController.text = word;
                    },
                  ),
                ),
              )
              .toList();

      // hive data
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: ListTile(
                leading: Text("최근 검색기록"),
              ),
            ),
            ...searchHistoryWidgets
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: products.length + 2,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (products.isEmpty) {
          return Container();
        }
        if (index == 0) {
          return Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('역삼동 기준 최저가 "${_searchProvider.searchedKeyword}"'),
                // DropdownButton
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      // surfaceTintColor: Colors.grey
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.all()
                      // )
                      ),
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Filters  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (index == products.length) {
          Future.microtask(() => _searchProvider.fetchNext());
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                tileColor: Colors.white,
                // focusColor: Colors.redAccent,
                minVerticalPadding: 0.0,
                contentPadding: EdgeInsets.all(0.0),
                onTap: () => _searchProvider.select(index),
                // onTap: () => print("choosed $index"),
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: index == _searchProvider.selected
                        ? const [
                            BoxShadow(
                              blurRadius: 30.0,
                              // offset: Offset(-28, -28),
                              color: Colors.white,
                              // inset: true,
                            ),
                            BoxShadow(
                              blurRadius: 30.0,
                              // offset: Offset(28, 28),
                              color: Color(0xFFA7A9AF),
                            )
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => index ==
                                    _searchProvider.selected
                                ? Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            // shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Container(
                                          width: 25,
                                          height: 25,
                                          color: Colors.white,
                                          // decoration: BoxDecoration(
                                          //   borderRadius:
                                          //       BorderRadius.horizontal(),
                                          //   // shape: BoxShape.circle,
                                          // ),
                                          margin: const EdgeInsets.all(8),
                                          child: IconButton(
                                            // style: ButtonStyle(
                                            //   shape: MaterialStateProperty.all<
                                            //       RoundedRectangleBorder>(
                                            //     RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               10.0),
                                            //       side: BorderSide(
                                            //           color: Colors.red),
                                            //     ),
                                            //   ),
                                            // ),
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.add,
                                              size: 14,
                                            ),
                                            onPressed: () {
                                              print("$index");
                                              _searchProvider
                                                  .addMartProductId(index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 100,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      // shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                            imageUrl: products[index].imageUrl ??
                                'https://www.thejungleadventure.com/assets/images/noimage/noimage.png',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Container(
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Container(
                            height: 80,
                            // width: 180,
                            // alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].martName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  products[index].productName ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  (products[index].unitValue.toString() ?? '') +
                                      (products[index].unit ?? ''),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _buildPriceTrailing(products[index])
                    ],
                  ),
                ),
                // trailing: _buildPriceTrailing(products[index]),
              ),
            ),
            const Divider(color: Colors.transparent),
          ],
        );
      },
    );
  }

  Container _buildPriceTrailing(MartProduct product) {
    final List<Widget> prices = [];
    if (product.discountPercent != 0) {
      prices.add(Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        child: Text(
          "Disc ${product.discountPercent}%",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ));
      prices.add(const Divider(height: 5));
      prices.add(Text(
        "${product.originalPrice}원",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.lineThrough),
      ));
      prices.add(const Divider(height: 5));
    }

    prices.add(Text(
      "${product.price}원",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: true,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ));

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      // width: MediaQuery.of(context).size.width * 0.18,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: prices,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          child: Center(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(200, 200, 203, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(200, 200, 203, 1),
                  ),
                ),
              ),
              onChanged: (text) {
                // 현재 텍스트필드의 텍스트를 출력
                // print("search input: $text");
              },
              onSubmitted: (value) async {
                if (_textEditingController.text == "") {
                  return;
                }

                await _searchProvider.search(_textEditingController.text);
                List<String>? list = searchHistory.get(0);

                if (list!.contains(_textEditingController.text)) {
                  list.remove(_textEditingController.text);
                  searchHistory.put(0, [...list, _textEditingController.text]);
                } else if (list.length < 5) {
                  searchHistory.put(0, [...list, _textEditingController.text]);
                } else {
                  list.removeAt(0);
                  searchHistory.put(0, [...list, _textEditingController.text]);
                }
              },
            ),
          ),
        ),
        actions: [
          Container(
            width: 50,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 28,
                color: Color.fromRGBO(200, 200, 203, 1),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => RecommendResultProvider(),
                      child: const RecommendResultPage(),
                    ),
                  ),
                );

                //   // todo : 옮겨야함
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const RecommendResultPage(),
                //     ),
                //   );
              },
            ),
          ),
        ],
      ),
      body: _renderListView(),
    );
  }
}
