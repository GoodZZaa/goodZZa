
class CheapestMart {
  CheapestMart({
    required this.martId,
    required this.martName,
    required this.imageUrl,
  });

  late int? martId;
  late String? martName;
  late String? imageUrl;

  CheapestMart.fromMap(Map<String, dynamic>? map) {
    martId = map?['martId'] ?? '';
    martName = map?['martName'] ?? '';
    imageUrl = map?['imageUrl'] ?? '';
  }
}

