class MartProduct {
  int? martProductId;
  String? martName;
  String? productName;
  String? imageUrl;
  int? price;
  int? originalPrice;
  int? discountPercent;
  String? unit;
  int? unitValue;
  int? productId;

  MartProduct({
    required this.martProductId,
    required this.martName,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    required this.unit,
    required this.unitValue,
    required this.productId,
  });

  MartProduct.fromJson(Map<String, dynamic> json) {
    martProductId = json['martProductId'];
    martName = json['martName'];
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    discountPercent = json['discountPercent'];
    unit = json['unit'];
    unitValue = json['unitValue'];
    productId = json['productId'];
  }
}
