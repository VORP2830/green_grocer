import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/page_routes/app_pages.dart';
import 'package:green_grocer/src/pages/auth/repositories/auth_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  final UtilsServices _utilsServices = UtilsServices();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    try {
      String? token = await _utilsServices.getLocalData(key: StorageKeys.token);
      if (token == null) {
        Get.offAllNamed(PagesRoutes.signInRoute);
        return;
      }
      user = await _authRepository.validateToken(token);
      saveTokenAndProceedToBase();
    } catch (e) {
      await signOut();
    }
  }

  void saveTokenAndProceedToBase() {
    _utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signOut() async {
    await _utilsServices.deleteLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      user = await _authRepository.signIn(email: email, password: password);
      saveTokenAndProceedToBase();
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      user = await _authRepository.signUp(user);
      saveTokenAndProceedToBase();
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      _authRepository.forgotPassword(email);
      _utilsServices.showToast(
        message: 'Email enviado com sucesso!',
        isError: false,
      );
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      final result = await _authRepository.changePassword(
        token: user.token!,
        email: user.email!,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      if (result) {
        _utilsServices.showToast(
          message: 'Senha alterada com sucesso!',
          isError: false,
        );
        signOut();
      } else {
        _utilsServices.showToast(
            message: 'Senha atual está incorreta', isError: true);
      }
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
