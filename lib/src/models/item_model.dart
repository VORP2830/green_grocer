class ItemModel {
  String name;
  String imageUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    required this.name,
    required this.imageUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      unit: json['unit'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'unit': unit,
      'price': price,
      'description': description,
    };
  }
}
