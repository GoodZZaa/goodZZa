
class Shoppingcart {
  Shoppingcart({
    required this.martProductId,
    required this.martName,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.amount,
  });

  late int martProductId;
  late String martName;
  late String productName;
  late String imageUrl;
  late int price;
  late int amount;

  Shoppingcart.fromMap(Map<String, dynamic>? map){
    martProductId = map?['martProductId']?? '';
    martName = map?['martName']?? '';
    productName = map?['productName']?? '';
    imageUrl = map?['imageUrl']?? '';
    price = map?['price']?? '';
    amount = map?['amount']?? '';
  }
}