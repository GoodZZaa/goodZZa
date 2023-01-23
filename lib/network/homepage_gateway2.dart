import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:good_zza_code_in_songdo/models/cheapest_mart.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:good_zza_code_in_songdo/pages/home_page.dart';


class HomepageGateway2{
  //Uri uri = Uri.parse('https://csms.moberan.com:443/api/v1/gateway?isFirst=false&latitude=0&longitude=0&pageSize=20&pageNumber=5');



  Future<List<CheapestMart>> getCheapestMart2({bool isFirst=true, int pageNumber=1}) async{
    List<CheapestMart> cheapestmart = [];



    var _baseUrl2 = "https://csms.moberan.com:443/api/v1/gateway";
    Map<String, String> queryParams = {
      "isFirst": isFirst.toString(),
      "longitude": 0.toString(),
      "latitude": 0.toString(),
      "pageSize": 20.toString(),
      "pageNumber": pageNumber.toString(),
    };

    var query = Uri(queryParameters: queryParams).query;
    Uri uri2 = Uri.parse("$_baseUrl2?$query");

    final response = await http.get(uri2);

    if(response.statusCode == 200) {
      var jsonmap = jsonDecode(utf8.decode(response.bodyBytes));
      cheapestmart = jsonmap['cheapestMarts'].map<CheapestMart>(
              (cheapestmart) {
            return CheapestMart.fromMap(cheapestmart);
          }).toList();
    }
    return cheapestmart;
  }
}

