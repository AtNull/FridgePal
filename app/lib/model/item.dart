class Item {
  String id;
  String name;
  DateTime purchaseDate;
  DateTime expiryDate;
  int quantity;
  String imageUrl;

  Item({required this.id, required this.name, required this.purchaseDate, required this.expiryDate, required this.quantity, required this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      purchaseDate: DateTime.tryParse(json['purchaseDate']) ?? DateTime.now(),
      expiryDate: DateTime.tryParse(json['expiryDate']) ?? DateTime.now(),
      quantity: json['quantity'] ?? 1,
      imageUrl: json['imageUrl'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'purchaseDate': purchaseDate.toUtc().toIso8601String(),
      'expiryDate': expiryDate.toUtc().toIso8601String(),
      'quantity': quantity,
      'imageUrl': imageUrl
    };
  }

  Item copyWith({
    String? name,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    int? quantity,
    String? imageUrl,
  }) {
    return Item(
      id: id,
      name: name ?? this.name,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}