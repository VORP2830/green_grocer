import 'package:green_grocer/src/constants/endpoint.dart';
import 'package:green_grocer/src/models/category_model.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/services/http_manager.dart';
import 'package:green_grocer/src/pages/home/repositories/home_errors.dart'
    as home_erros;

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getAllCategories,
      method: HttpMethods.post,
    );
    if (result['result'] != null) {
      List<CategoryModel> categories =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return categories;
    } else {
      throw home_erros.categoryHomeErrorsString(result['error']);
    }
  }

  Future<List<ItemModel>> getAllProducts(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );
    if (result['result'] != null) {
      List<ItemModel> products =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(ItemModel.fromJson)
              .toList();
      return products;
    } else {
      throw home_erros.productsHomeErrorsString(result['error']);
    }
  }
}
