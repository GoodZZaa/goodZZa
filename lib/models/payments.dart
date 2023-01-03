class PaymentItem {
  int year;
  int month;
  DateTime date;
  String productName;
  int price;
  int amount;

  PaymentItem(
      {required this.amount,
      required this.price,
      required this.productName,
      required this.date,
      required this.month,
      required this.year});
}
