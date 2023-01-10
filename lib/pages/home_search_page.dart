import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return ListView.builder(
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
        return ListTile(
          title: Text(
            products[index].productName ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
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
      // Consumer<SearchProvider>(builder: (context, data, index) {
      //   return _renderListView();
      // }),

      // ListView(
      //   children: _searchProvider.products
      //       .map(
      //         (e) => ListTile(
      //           title: Text(
      //             e.productName ?? '',
      //             style: const TextStyle(
      //               color: Colors.black,
      //               fontSize: 16,
      //               fontWeight: FontWeight.w700,
      //             ),
      //           ),
      //         ),
      //       )
      //       .toList(),
      // ),
    );
  }
}
