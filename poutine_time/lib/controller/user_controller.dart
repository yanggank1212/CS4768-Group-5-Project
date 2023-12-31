/// This is the Controler for the User Model
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/model/user_model.dart';

class UserController {
  late User user;
  late UserModel userModel;

  UserController() {}

  void setUser() {
    user = FirebaseAuth.instance.currentUser!;
  }

  String getUserID() {
    return user.uid;
  }

  String getUsername() {
    return userModel.username;
  }

  void setUserModel(UserModel userModel) {
    this.userModel = userModel;
  }

  Future<UserModel?> getUserModelData(String userID) async {
    try {
      // Load userList from Firestore Database "Data/userList"
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Data');
      DocumentSnapshot userListDoc = await dataCollection.doc('userList').get();

      return UserModel.fromMap(userListDoc, userID);
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print('Error fetching user model: $e');
      String username = user.email?.split('@')[0] as String;
      UserModel userModel = UserModel(username: username);

      await FirebaseFirestore.instance
          .collection('Data')
          .doc("userList")
          .update({userID: userModel.toMap()});
      return userModel;
    }
  }
  Future<void> updateUserModel(String userID, UserModel updatedUserModel) async {
    try {
      // Update the user's data in the Firestore database
      await FirebaseFirestore.instance
          .collection('Data')
          .doc("userList")
          .update({
        userID: updatedUserModel.toMap(),
      });
    } catch (e) {
      // Handle any errors that might occur during the update
      print('Error updating user model: $e');
    }
  }

  Future<void> reloadUserModel() async {
    try {
      String userID = getUserID();
      UserModel? updatedUserModel = await getUserModelData(userID);
      if (updatedUserModel != null) {
        setUserModel(updatedUserModel);
      }
    } catch (e) {
      print('Error reloading user model: $e');
    }
  }

// ... existing methods ...


  Future<void> changeUsername(String newUsername) async {
    try {
      // Update Firestore with the new username
      await FirebaseFirestore.instance
          .collection('Data')
          .doc('userList')
          .update({getUserID(): {'username': newUsername}});

      // Update the local userModel with the new username
      userModel.username = newUsername;
    } catch (e) {
      print('Error changing username: $e');
    }
  }
}


