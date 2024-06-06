import 'package:green_grocer/src/constants/endpoint.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repositories/auth_errors.dart'
    as auth_errors;
import 'package:green_grocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  UserModel handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      return UserModel.fromJson(result['result']);
    } else {
      throw auth_errors.authErrorsString(result['error']);
    }
  }

  Future<UserModel> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.validateToken,
      method: HttpMethods.post,
      headers: {
        'x-parse-session-token': token,
      },
    );
    return handleUserOrError(result);
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );
    return handleUserOrError(result);
  }

  Future<UserModel> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );
    return handleUserOrError(result);
  }

  Future<void> forgotPassword(String email) async {
    _httpManager.restRequest(
      url: Endpoint.forgotPassword,
      method: HttpMethods.post,
      body: {
        'email': email,
      },
    );
  }
}
