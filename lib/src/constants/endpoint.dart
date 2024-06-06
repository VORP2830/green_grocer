const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoint {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
}