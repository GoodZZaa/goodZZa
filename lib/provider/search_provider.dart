import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:good_zza_code_in_songdo/models/mart_product.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  final _baseUrl = 'https://csms.moberan.com/api/v1/search/products';

  double _testLatitude = 37.417787047798726;
  double _testLongitude = 126.67894010239827;

  final int _pageSize = 20;
  int _pageNumber = 0;
  bool isLoading = false;
  bool _hasNextPage = true;
  int selected = -1;

  // bool _isLoadMoreRunning = false;
  String searchedKeyword = "";
  List<MartProduct> _products = [];

  List<MartProduct> get products => _products;

  _init() {
    _pageNumber = 0;
    _hasNextPage = true;
    isLoading = false;
    _products.clear();
  }

  fetchNext() {
    _pageLoad(searchedKeyword);
  }

  void _pageLoad(String keyword) async {
    isLoading = true;
    notifyListeners();

    try {
      Map<String, String> queryParams = {
        "keyword": keyword,
        "latitude": _testLatitude.toString(),
        "longitude": _testLongitude.toString(),
        "pageSize": _pageSize.toString(),
        "pageNumber": _pageNumber.toString(),
      };
      var query = Uri(queryParameters: queryParams).query;
      final response = await http.get(Uri.parse("$_baseUrl?$query"));

      if (response.statusCode != 200) {
        throw Exception("failed to call search API, keyword: $keyword");
      }

      String body = utf8.decode(response.bodyBytes);
      var json = jsonDecode(body);
      var martProducts = (json["martProducts"] as List)
          .map((e) => MartProduct.fromJson(e))
          .toList();
      _products = [..._products, ...martProducts];

      _pageNumber = json["pageNumber"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  search(String keyword) async {
    if (searchedKeyword == keyword) {
      return;
    }
    _init();

    _pageLoad(keyword);
    searchedKeyword = keyword;
  }

  select(int index) async {
    selected = index;
    notifyListeners();
  }

  addMartProductId(int martProductId) async {
    try {
      Map<String, int> body = {
        "martProductId": martProductId,
      };
      final response = await http.post(
          Uri.parse("https://csms.moberan.com/api/v1/checkout"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode != 200) {
        throw Exception(
            "failed to call checkout API, martProductId: $martProductId");
      }

      Fluttertoast.showToast(
          msg: "??????????????? ????????? ?????????????????????.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
