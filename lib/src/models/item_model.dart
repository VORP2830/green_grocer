class ItemModel {
  String? id;
  String name;
  String imageUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['title'],
      imageUrl: json['picture'],
      unit: json['unit'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'picture': imageUrl,
      'unit': unit,
      'price': price,
      'description': description,
    };
  }

  @override
  String toString() =>
      'ItemModel(id: $id, title: $name, picture: $imageUrl, unit: $unit, price: $price, description: $description)';
}
