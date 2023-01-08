import 'dart:convert';

class MonthlyPayoutResponse {
  final List<PayoutItem> payoutItems;
  MonthlyPayoutResponse({required this.payoutItems});

  factory MonthlyPayoutResponse.fromJson(String jsonString) {
    List<dynamic> listFromJson = json.decode(jsonString);

    List<PayoutItem> items =
        listFromJson.map((e) => PayoutItem.fromJson(e)).toList();
    return MonthlyPayoutResponse(payoutItems: items);
  }
}

class PayoutItem {
  String date;
  List<String> products;
  int totalPrice;
  String market;

  PayoutItem(
      {required this.date,
      required this.products,
      required this.totalPrice,
      required this.market});

  factory PayoutItem.fromJson(Map<String, dynamic> json) => PayoutItem(
      date: json['date'],
      products: json['products'] as List<String>,
      totalPrice: json['totalPrice'],
      market: json['market']);
}
