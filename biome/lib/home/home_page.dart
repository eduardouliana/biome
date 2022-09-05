import 'package:biome/core/app_colors.dart';
import 'package:biome/database/user_db.dart';
import 'package:biome/home/widgets/drawer_widget.dart';
import 'package:biome/models/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  User? userParam;

  HomePage({
    this.userParam,
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDB userDB = UserDB();

  Stream<User> get loggedUser => userDB.getLoggedUser(widget.userParam!.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Olá, " + widget.userParam!.nome,
        ),
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder<User>(
        stream: loggedUser,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.header,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Icon(
                          Icons.monetization_on_outlined,
                          size: 72,
                          color: Colors.yellow,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Você possui",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            snapshot.data!.pontos.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                          const Text(
                            "pontos",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.header,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Icon(
                          Icons.recycling,
                          size: 72,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Itens reciclados",
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "* " +
                                snapshot.data!.itens_2l.toString() +
                                " Garrafas plásticas de 2L",
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            "* " +
                                snapshot.data!.itens_500ml.toString() +
                                " Garrafas plásticas de 500ml",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
