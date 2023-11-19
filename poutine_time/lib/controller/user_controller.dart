/// This is the Controler for the User Model
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/model/user_model.dart';

class UserController {
  final user = FirebaseAuth.instance.currentUser;

  String? getUserID() {
    return user?.uid;
  }

  Future<UserModel> getUserModel() async {
    CollectionReference dataCollection =
        FirebaseFirestore.instance.collection('Data');
    DocumentSnapshot userListDoc = await dataCollection.doc('userList').get();
    String? userID = getUserID();

    return UserModel.fromMap(userListDoc, getUserID()!);
  }
}
