import 'package:green_grocer/src/constants/endpoint.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/repositories/auth_errors.dart'
    as auth_errors;
import 'package:green_grocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<UserModel> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.validateToken,
      method: HttpMethods.post,
      headers: {
        'x-parse-session-token': token,
      },
    );
    if (result['result'] != null) {
      return UserModel.fromJson(result['result']);
    } else {
      throw auth_errors.authErrorsString(result['error']);
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (result['result'] != null) {
      return UserModel.fromJson(result['result']);
    } else {
      throw auth_errors.authErrorsString(result['error']);
    }
  }
}
