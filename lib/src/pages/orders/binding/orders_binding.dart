import 'package:get/get.dart';
import 'package:green_grocer/src/pages/orders/controllers/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersController());
  }
}
