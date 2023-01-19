import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:good_zza_code_in_songdo/models/cheapest_mart.dart';
import 'package:good_zza_code_in_songdo/models/cheapest_product.dart';


class HomepageGateway{
  //Uri uri = Uri.parse('https://csms.moberan.com:443/api/v1/gateway?isFirst=false&latitude=0&longitude=0&pageSize=20&pageNumber=5');



  Future<List<CheapestProduct>> getCheapestProduct({bool isFirst=true, int pageNumber=1}) async{
    List<CheapestProduct> cheapestproduct = [];
    List<CheapestMart> cheapestmart = [];


    var _baseUrl = "https://csms.moberan.com:443/api/v1/gateway";
    Map<String, String> queryParams = {
      "isFirst": isFirst.toString(),
      "longitude": 0.toString(),
      "latitude": 0.toString(),
      "pageSize": 20.toString(),
      "pageNumber": pageNumber.toString(),
    };

    var query = Uri(queryParameters: queryParams).query;
    Uri uri = Uri.parse("$_baseUrl?$query");

    final response = await http.get(uri);

    if(response.statusCode == 200) {
      var jsonmap = jsonDecode(utf8.decode(response.bodyBytes));
      cheapestproduct = jsonmap['cheapestProducts'].map<CheapestProduct>(
              (cheapestproduct) {
            return CheapestProduct.fromMap(cheapestproduct);
          }).toList();
    }
    return cheapestproduct;
  }
}