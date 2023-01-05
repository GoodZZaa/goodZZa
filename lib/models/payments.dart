class PaymentItem {
  int year;
  int month;
  DateTime date;
  String productName;
  String market;
  int price;
  int amount;

  PaymentItem(
      {required this.amount,
      required this.price,
      required this.productName,
      required this.market,
      required this.date,
      required this.month,
      required this.year});
}
