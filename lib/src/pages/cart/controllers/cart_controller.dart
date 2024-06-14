import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:green_grocer/src/pages/cart/repositories/cart_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';
import 'package:green_grocer/src/widgets/payment_dialog.dart';

class CartController extends GetxController {
  final _cartRepository = CartRepository();
  final _authController = Get.find<AuthController>();
  final UtilsServices _utilsServices = UtilsServices();
  bool isCheckoutLoding = false;

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  void setCheckoutLoding(bool value) {
    isCheckoutLoding = value;
    update();
  }

  Future<void> getCartItems() async {
    try {
      final List<CartItemModel> result = await _cartRepository.getCartItems(
        token: _authController.user.token!,
        userId: _authController.user.id!,
      );
      cartItems = result;
      update();
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    }
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((element) => element.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
          item: product, quantity: (product.quantity + quantity));
    } else {
      try {
        final String cartItemId = await _cartRepository.addCartItem(
          userId: _authController.user.id!,
          token: _authController.user.token!,
          productId: item.id!,
          quantity: quantity,
        );

        cartItems.add(
          CartItemModel(
            id: cartItemId,
            item: item,
            quantity: quantity,
          ),
        );
        update();
      } catch (e) {
        _utilsServices.showToast(message: e.toString(), isError: true);
      }
    }
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    try {
      final result = await _cartRepository.changeItemQuantity(
        token: _authController.user.token!,
        cartItemId: item.id,
        quantity: quantity,
      );

      if (result) {
        if (quantity == 0) {
          cartItems.removeWhere((cartItem) => cartItem.id == item.id);
        } else {
          cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
              quantity;
        }
        update();
      } else {
        _utilsServices.showToast(
            message: 'Falha ao alterar a quantidade do produto', isError: true);
      }
      return result;
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
      return false;
    }
  }

  Future checkoutCart() async {
    try {
      setCheckoutLoding(true);
      OrderModel result = await _cartRepository.checkoutCart(
        token: _authController.user.token!,
        total: cartTotalPrice(),
      );
      cartItems.clear();
      update();
      showDialog(
        context: Get.context!,
        builder: (_) {
          return PaymentDialog(
            order: result,
          );
        },
      );
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      setCheckoutLoding(false);
    }
  }
}
