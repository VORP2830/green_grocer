import 'package:green_grocer/src/constants/endpoint.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<List<CartItemModel>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );
    if (result['result'] != null) {
      List<CartItemModel> cartItems =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return cartItems;
    } else {
      throw 'Falha ao buscar itens do carrinho';
    }
  }

  Future<String> addCartItem({
    required String token,
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.addCartItem,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
        'productId': productId,
        'quantity': quantity,
      },
    );
    if (result['result'] != null) {
      return result['result']['id'];
    } else {
      throw 'Falha ao adicionar item ao carrinho';
    }
  }

  Future<bool> changeItemQuantity(
      {required String token,
      required String cartItemId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.modifyCartItem,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
    );
    return result.isEmpty;
  }

  Future<OrderModel> checkoutCart({required String token, required double total}) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.checkout,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'total': total,
      },
    );
    if (result['result'] != null) {
      return OrderModel.fromJson(result['result']);
    } else {
      throw 'Falha ao realizar checkout';
    }
  }
}
