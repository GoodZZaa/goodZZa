import 'dart:convert';

import 'package:intl/intl.dart';

class MonthlyPayoutResponse {
  final List<PayoutItem> payoutItems;
  MonthlyPayoutResponse({required this.payoutItems});

  factory MonthlyPayoutResponse.fromJson(List<dynamic> listFromJson) {
    List<PayoutItem> items =
        listFromJson.map((e) => PayoutItem.fromJson(e)).toList();
    return MonthlyPayoutResponse(payoutItems: items);
  }
}

class PayoutItem {
  DateTime date;
  List<dynamic> products;
  int totalPrice;
  String market;

  PayoutItem(
      {required this.date,
      required this.products,
      required this.totalPrice,
      required this.market});

  factory PayoutItem.fromJson(Map<String, dynamic> json) {
    List<String> products = (json['products'] as List<dynamic>)
        .map(
          (e) => e.toString(),
        )
        .toList();

    return PayoutItem(
        date: DateFormat('yyyy-MM-dd').parse(json['date']),
        products: products,
        totalPrice: json['totalPrice'],
        market: ' json[]');
  }
  // factory PayoutItem.fromJson(Map<String, dynamic> jsonMap) {
  //   List<String> b = json.decode(jsonMap['products']);

  //   return PayoutItem(
  //       date: jsonMap['date'],
  //       products: b,
  //       totalPrice: jsonMap['totalPrice'],
  //       market: jsonMap['market']);
  // }
}
