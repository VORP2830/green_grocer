import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:green_grocer/src/services/validator.dart';
import 'package:green_grocer/src/widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = _authController.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          'Perfil do usuario',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              _authController.signOut();
            },
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
            label: 'Email',
            icon: Icons.email,
            initialValue: user.email,
            readOnly: true,
          ),
          //Nome
          CustomTextField(
            label: 'Nome',
            icon: Icons.person,
            initialValue: user.name,
            readOnly: true,
          ),
          //Celular
          CustomTextField(
            label: 'Celular',
            icon: Icons.phone,
            initialValue: user.phone,
            readOnly: true,
          ),
          //CPF
          CustomTextField(
            label: 'CPF',
            icon: Icons.file_copy,
            isSecret: true,
            initialValue: user.cpf,
            readOnly: true,
          ),
          //Botao
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                updatePassword();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Atualizar senha',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Titulo
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualizar senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Senha atual
                      CustomTextField(
                        controller: currentPasswordController,
                        label: 'Senha atual',
                        icon: Icons.lock,
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      //Nova senha
                      CustomTextField(
                        controller: newPasswordController,
                        label: 'Nova senha',
                        icon: Icons.lock_outline,
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      //Confirmar nova senha
                      CustomTextField(
                        label: 'Confirmar nova senha',
                        icon: Icons.lock_outline,
                        isSecret: true,
                        validator: (password) {
                          final result = passwordValidator(password);
                          if (result != null) {
                            return result;
                          }
                          if (password != newPasswordController.text) {
                            return 'As senhas não são iguais';
                          }
                          return null;
                        },
                      ),
                      //Botao
                      SizedBox(
                        height: 45,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: _authController.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      _authController.changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                  },
                            child: _authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Atualizar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Botao fechar
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
