import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_zza_code_in_songdo/models/mart_product.dart';
import 'package:good_zza_code_in_songdo/provider/search_provider.dart';
import 'package:provider/provider.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPage();
}

class _HomeSearchPage extends State<HomeSearchPage> {
  late SearchProvider _searchProvider;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _searchProvider.dispose();
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
      // hive data
      return Center(
        child: Text('아이템이 없습니다.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        itemCount: products.length + 1,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (products.isEmpty) {
            return Container();
          }
          if (index == products.length) {
            Future.microtask(() => _searchProvider.fetchNext());
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const Divider(color: Colors.white),
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                // tileColor: Colors.cyanAccent,
                // focusColor: ,
                minVerticalPadding: 0.0,

                contentPadding: EdgeInsets.all(0.0),
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        margin: const EdgeInsets.all(10),
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      imageUrl: products[index].imageUrl ??
                          'https://www.thejungleadventure.com/assets/images/noimage/noimage.png',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        width: 100,
                        height: 70,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Container(
                      height: 80,
                      // width: 180,
                      // alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.40,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].martName ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            products[index].productName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
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
                    // buildPrice(products[index]),
                  ],
                ),
                trailing: _buildPriceTrailing(products[index]),
              ),
            ],
          );
        },
      ),
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

      prices.add(Text(
        "${product.originalPrice}원",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ));
    }

    prices.add(Text(
      "${product.price.toString()}원",
      // "10000원",
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: prices,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                // _textEditingController.text = value;
                await _searchProvider.search(_textEditingController.text);
              },
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          Container(
            width: 50,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 28,
                color: Color.fromRGBO(200, 200, 203, 1),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _renderListView(),
    );
  }
}
