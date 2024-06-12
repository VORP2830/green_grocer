import 'package:get/get.dart';
import 'package:green_grocer/src/pages/base/controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}