import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/models/mart_product.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  final _baseUrl = 'https://csms.moberan.com/api/v1/search/products';

  double _testLatitude = 37.417787047798726;
  double _testLongitude = 126.67894010239827;

  final int _pageSize = 20;
  int _pageNumber = 0;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  String _previousKeyword = "";
  List<MartProduct> _products = [];

  List<MartProduct> get products => _products;

  void _firstLoad(String keyword) async {
    _isFirstLoadRunning = true;

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
      _products = martProducts;

      _pageNumber = json["pageNumber"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    } finally {
      _isFirstLoadRunning = false;
      notifyListeners();
    }
  }

  search(String keyword) async {
    if (_previousKeyword == keyword) {
      return;
    }

    _firstLoad(keyword);
    _previousKeyword = keyword;
  }
}