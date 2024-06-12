import 'package:green_grocer/src/constants/endpoint.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<List<CartItemModel>> getOrderItems({
    required String token,
    required String orderId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getOrderItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'orderId': orderId,
      },
    );
    if (result['result'] != null) {
      List<CartItemModel> items =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CartItemModel.fromJson)
              .toList();
      return items;
    } else {
      throw 'Erro ao buscar itens do pedido';
    }
  }

  Future<List<OrderModel>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      List<OrderModel> orders =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(OrderModel.fromJson)
              .toList();
      return orders;
    } else {
      throw 'Erro ao buscar pedidos';
    }
  }
}
