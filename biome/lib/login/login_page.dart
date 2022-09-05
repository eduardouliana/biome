import 'package:biome/core/app_colors.dart';
import 'package:biome/database/user_db.dart';
import 'package:biome/home/home_page.dart';
import 'package:biome/models/user.dart';
import 'package:biome/signup/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 85),
          child: Column(children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 44,
              width: 138,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryGreen,
              ),
              child: TextButton(
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  String login = _userController.text;
                  String pwd = _passwordController.text;

                  UserDB userDB = UserDB();
                  try {
                    User user = await userDB.authenticate(login, pwd);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => HomePage(
                                userParam: user,
                              )),
                    );
                  } catch (_) {
                    showAlertDialog(context);
                  }
                },
              ),
            )
          ]),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primaryGreen,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Dados incorretos"),
    content: const Text("CPF ou senha inválidos"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
