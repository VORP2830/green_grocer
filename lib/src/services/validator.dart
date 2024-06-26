import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email!';
  }
  if (!email.isEmail) return 'Digite um email válido!';
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha!';
  }
  if (password.length < 6) {
    return 'Senha deve ter no mínimo 6 caracteres!';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu nome!';
  }
  final names = name.split(' ');
  if (names.length == 1) {
    return 'Digite seu nome completo!';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite seu celular!';
  }
  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido!';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite seu CPF!';
  }
  if (!cpf.isCpf) {
    return 'Digite um CPF válido!';
  }
  return null;
}
