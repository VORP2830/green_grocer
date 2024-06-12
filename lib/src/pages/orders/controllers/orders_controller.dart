import 'package:get/get.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:green_grocer/src/pages/orders/repositories/orders_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class OrdersController extends GetxController {
  final _ordersRepository = OrdersRepository();
  final _authController = Get.find<AuthController>();
  final _utilsService = UtilsServices();
  List<OrderModel> orders = [];

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    try {
      List<OrderModel> orders = await _ordersRepository.getAllOrders(
        userId: _authController.user.id!,
        token: _authController.user.token!,
      );
      orders.sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
      update();
    } catch (e) {
      _utilsService.showToast(message: e.toString(), isError: true);
    }
  }
}
