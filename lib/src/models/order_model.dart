import 'package:green_grocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime? createdDateTime;
  DateTime overdueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPast;
  double total;
  String qrCodeImage;

  bool get isOverDue => overdueDateTime.isBefore(DateTime.now());

  OrderModel({
    required this.id,
    this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPast,
    required this.total,
    required this.qrCodeImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdDateTime: DateTime.parse(json['createdAt']),
      overdueDateTime: DateTime.parse(json['due']),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      status: json['status'],
      copyAndPast: json['copiaecola'],
      qrCodeImage: json['qrCodeImage'],
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdDateTime?.toIso8601String(),
      'due': overdueDateTime.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'copiaecola': copyAndPast,
      'qrCodeImage': qrCodeImage,
      'total': total,
    };
  }
}
