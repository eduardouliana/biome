import 'package:biome/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  final String _table = "usuarios";
  final String _logged_user = "usuario_logado";

  Stream<List<User>> getUsers() {
    return _db.collection(_table).snapshots().map((snapshot) => snapshot.docs
        .map(
          (doc) => User.fromJson(
            doc.data(),
          ),
        )
        .toList());
  }

  Stream<User> getLoggedUser(String id) {
    return _db
        .collection(_table)
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => User.fromJson(
                doc.data(),
              ),
            )
            .toList()[0]);
  }

  saveUser(User user) {
    _db.collection(_table).doc(user.id).set(user.toMap());
  }

  deleteUser(String id) {
    _db.collection(_table).doc(id).delete();
  }

  Future<User> authenticate(String cpf, String pwd) async {
    QuerySnapshot user = await _db
        .collection(_table)
        .where('cpf', isEqualTo: cpf)
        .where('senha', isEqualTo: pwd)
        .get();

    if (user.docs.isEmpty) {
      throw Exception();
    }

    User _user = User.fromJson(user.docs.single.data() as Map<String, dynamic>);

    _db.collection(_logged_user).doc('usuario').set(_user.idToMap());

    return _user;
  }
}
