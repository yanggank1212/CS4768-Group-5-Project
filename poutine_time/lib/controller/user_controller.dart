/// This is the Controler for the User Model
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/model/user_model.dart';

class UserController {
  final user = FirebaseAuth.instance.currentUser;

  String? getUserID() {
    return user?.uid;
  }

  Future<UserModel> getUserModel() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Data');
      DocumentSnapshot userListDoc = await dataCollection.doc('userList').get();

      if (userListDoc.exists) {
        return UserModel.fromMap(userListDoc, getUserID()!);
      } else {
        // Handle the case where the document does not exist
        return UserModelTemplate().userModelTemplate();
      }
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print('Error fetching user model: $e');
      return UserModelTemplate().userModelTemplate();
    }
  }
}
