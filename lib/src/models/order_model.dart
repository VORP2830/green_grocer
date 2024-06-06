import 'package:green_grocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPast;
  double total;

  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPast,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
      overdueDateTime: DateTime.parse(json['overdueDateTime']),
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      status: json['status'],
      copyAndPast: json['copyAndPast'],
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDateTime': createdDateTime.toIso8601String(),
      'overdueDateTime': overdueDateTime.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'copyAndPast': copyAndPast,
      'total': total,
    };
  }
}
