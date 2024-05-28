import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_grocer/src/widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final user = app_data.user;

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
                padding: EdgeInsets.all(16),
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
                    const CustomTextField(
                      label: 'Senha atual',
                      icon: Icons.lock,
                      isSecret: true,
                    ),
                    //Nova senha
                    const CustomTextField(
                      label: 'Nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    //Confirmar nova senha
                    const CustomTextField(
                      label: 'Confirmar nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    //Botao
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Atualizar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
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
