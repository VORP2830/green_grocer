import 'package:get/get.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:green_grocer/src/pages/orders/repositories/orders_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController(this.order);
  final _orderRepository = OrdersRepository();
  final _authController = Get.find<AuthController>();
  final _utilsService = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final List<CartItemModel> result = await _orderRepository.getOrderItems(
      token: _authController.user.token!,
      orderId: order.id,
    );
    try {
      order.items = result;
      update();
    } catch (e) {
      _utilsService.showToast(message: e.toString(), isError: true);
    } finally {
      setLoading(false);
    }
  }
}
