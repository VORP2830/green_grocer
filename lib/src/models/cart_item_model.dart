import 'package:green_grocer/src/models/item_model.dart';

class CartItemModel {
  String id;
  int quantity;
  ItemModel item;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.item,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      quantity: json['quantity'],
      item: ItemModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': item.toJson(),
    };
  }

  double totalPrice() => item.price * quantity;
}
