import 'package:biome/core/app_colors.dart';
import 'package:biome/database/user_db.dart';
import 'package:biome/models/user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserDB userDB = UserDB();

  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _senhaController;

  @override
  void initState() {
    super.initState();

    _nomeController = TextEditingController();
    _cpfController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 44,
                width: 138,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryGreen,
                ),
                child: TextButton(
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    String id = const Uuid().v1();

                    User user = User(
                      id: id,
                      nome: _nomeController.text,
                      cpf: _cpfController.text,
                      email: _emailController.text,
                      telefone: _telefoneController.text,
                      senha: _senhaController.text,
                      itens_2l: 0,
                      itens_500ml: 0,
                      pontos: 0,
                    );

                    userDB.saveUser(user);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cadastrado com sucesso"),
                      ),
                    );

                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
