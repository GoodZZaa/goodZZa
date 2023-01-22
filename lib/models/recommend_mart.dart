class RecommendMart {
  RecommendMart({
    required this.martId,
    required this.martName,
    required this.imageUrl,
    required this.estimatedPrice,
    required this.distance,
  });

  late int? martId;
  late String? martName;
  late String? imageUrl;
  late int? estimatedPrice;
  late double? distance;

  RecommendMart.fromMap(Map<String, dynamic>? map) {
    martId = map?['martId'] ?? '';
    martName = map?['martName'] ?? '';
    imageUrl = map?['imageUrl'] ?? '';
    estimatedPrice = map?['estimatedPrice'] ?? '';
    distance = map?['distance'] ?? '';
  }
}
