class Food {
  String name;
  String description;
  String location;
  double rating;
  double price;
  bool isLiked;
  String pictureUrl;
  String documentId;

  Food({
    required this.name,
    required this.description,
    required this.location,
    required this.rating,
    required this.price,
    required this.isLiked,
    required this.pictureUrl,
    required this.documentId,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    // print("Print map");
    // print(map.g);
    return Food(
      documentId: map['documentId'] ?? '',
      name: map['destinationName'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : 0.0,
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
      isLiked: false,
      pictureUrl: map['pictureUrl'] ?? '',
    );
  }
}
