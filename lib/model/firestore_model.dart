import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nina_homework/model/user_model.dart';

class FirestoreService {
  final userModel = FirebaseFirestore.instance.collection('UserProfile');

  // CREATE
  Future<void> addUser(UserModel user) {
    return userModel.add(user.toJson());
  }

  // READ
  Stream<QuerySnapshot> getUserStream() {
    final userStream = userModel.snapshots();
    return userStream;
  }

  // UPDATE
  Future<void> updateUser(String userId, UserModel user) {
    return userModel.doc(userId).update(user.toJson());
  }

  // DELETE
  Future<void> deleteUser(String userId) {
    return userModel.doc(userId).delete();
  }
}
