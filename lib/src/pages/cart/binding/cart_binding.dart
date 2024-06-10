import 'package:get/get.dart';
import 'package:green_grocer/src/pages/cart/controllers/cart_controller.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CartController());
  }
}