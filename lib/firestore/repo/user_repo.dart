import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dishcord/firestore/model/user.dart' as Model;

class UserRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('user');

  Future<DocumentReference> saveUser(Model.User user) async {
    return await _ref.add(user.toMap());
  }

  Future<Model.User> getUser() async {
    final snapshot = await _ref
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get();

    final doc = snapshot.docs[0]; //bad idea?
    return Model.User(
      id: doc.id,
      email: doc.data()['email'],
      username: doc.data()['username'],
      chatIconColor: doc.data()['chat_icon_color'],
    );
  }
}
