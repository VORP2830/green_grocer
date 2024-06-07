import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:green_grocer/src/services/validator.dart';
import 'package:green_grocer/src/widgets/custom_button.dart';
import 'package:green_grocer/src/widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  //Formulário
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 40),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            label: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (value) {
                              _authController.user.email = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Senha',
                            icon: Icons.lock,
                            isSecret: true,
                            validator: passwordValidator,
                            onSaved: (value) {
                              _authController.user.password = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Nome',
                            icon: Icons.person,
                            validator: nameValidator,
                            onSaved: (value) {
                              _authController.user.name = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Celular',
                            icon: Icons.phone,
                            inputFormatters: [phoneFormatter],
                            keyboardType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (value) {
                              _authController.user.phone = value;
                            },
                          ),
                          CustomTextField(
                            label: 'CPF',
                            icon: Icons.file_copy,
                            inputFormatters: [cpfFormatter],
                            keyboardType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (value) {
                              _authController.user.cpf = value;
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () {
                                return CustomButton(
                                  label: 'Cadastrar usuário',
                                  isLoading: _authController.isLoading.value,
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _authController.signUp();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
