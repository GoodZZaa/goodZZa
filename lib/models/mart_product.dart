class SearchResponse {
  int martProductId;
  String productName;
  String imageUrl;
  int price;
  int originalPrice;
  int discountPercent;
  String unit;
  int unitValue;
  int productId;

  PaymentItem(
      {required this.martProductId,
      required this.productName,
      required this.imageUrl,
      required this.price,
      required this.originalPrice,
      required this.discountPercent,
      required this.unit,
      required this.unitValue,
      required this.unitValue});
}
