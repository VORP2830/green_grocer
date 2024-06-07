import 'package:green_grocer/src/models/item_model.dart';

class CategoryModel {
  String id;
  String title;
  List<ItemModel> items;
  int pagination = 0;

  CategoryModel({
    required this.id,
    required this.title,
    this.items = const [],
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      items: json['items'] != null
          ? List<ItemModel>.from(
              json['items'].map((x) => ItemModel.fromJson(x)),
            )
          : [],
      pagination: json['pagination'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'items': items.map((x) => x.toJson()).toList(),
      'pagination': pagination,
    };
  }

  @override
  String toString() => 'CategoryModel(id: $id, title: $title)';
}
