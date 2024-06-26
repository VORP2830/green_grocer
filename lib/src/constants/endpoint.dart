const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoint {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String forgotPassword = '$baseUrl/reset-password';
  static const String getAllCategories = '$baseUrl/get-category-list';
  static const String getAllProducts = '$baseUrl/get-product-list';
  static const String getCartItems = '$baseUrl/get-cart-items';
  static const String addCartItem = '$baseUrl/add-item-to-cart';
  static const String modifyCartItem = '$baseUrl/modify-item-quantity';
  static const String checkout = '$baseUrl/checkout';
  static const String getOrders = '$baseUrl/get-orders';
  static const String getOrderItems = '$baseUrl/get-order-items';
  static const String changePassword = '$baseUrl/change-password';
}