import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:good_zza_code_in_songdo/models/shoppingcartdata.dart';

class Checkout{

  Future<List<Shoppingcart>> getShoppingCart() async{
    List<Shoppingcart> shoppingcart = [];


    Uri uri = Uri.parse('https://csms.moberan.com:443/api/v1/checkout');

    final response = await http.get(uri);

    if(response.statusCode == 200) {
      var jsonmap = jsonDecode(utf8.decode(response.bodyBytes));
      shoppingcart = jsonmap['products'].map<Shoppingcart>(
              (shoppingcart) {
            return Shoppingcart.fromMap(shoppingcart);
          }).toList();
    }
    return shoppingcart;


  }
}