import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';
import 'package:reconnect/Views/authentications/user_repo.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

class Profilecontroller extends GetxController {
  static Profilecontroller get to => Get.find();
  
  
  final _authrepo = Get.put(Authentication());
  final _userrepo = Get.put(User_report());

  getuserdata() {
    final email = _authrepo.firebaseuser.value?.email;
    if (email != null) {
      return _userrepo.getuserdata(email);
    } else {
      Get.snackbar("error", "login to continue");
    }
    // final name=_authrepo.firebaseuser.value.displayName;
    // final image=_authrepo.firebaseuser.value.photoURL;
    // final uid=_authrepo.firebaseuser.value.uid;
    // final phone=_authrepo.firebaseuser.value.phoneNumber;
    // final email=_authrepo.firebaseuser.value.email;
    // final name=_authrepo.firebaseuser.value.displayName;
  }

  //updateRecord(UserModel user) async {
    //await _userrepo.updateUserData(user);
  //}



   Future<void> updateRecord(UserModel user, {bool updateAuth = false}) async {
  // Get the current user's email
  final email = FirebaseAuth.instance.currentUser!.email;

  // Query Firestore to find the user document with the provided email
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  // Check if any documents match the query
  if (querySnapshot.docs.isNotEmpty) {
    // Get the user document
    QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;

    // Get the user ID
    String userId = userDoc.id;

    try {
      // Update the user document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(user.toJson());

      // Update user's email and password in Firebase Authentication if needed
      if (updateAuth) {
        // Update email if it has changed
        if (user.email != email) {
          await FirebaseAuth.instance.currentUser!.updateEmail(user.email);
        }

        // Update password if it has changed
        if (user.password != null && user.password.isNotEmpty) {
          await FirebaseAuth.instance.currentUser!.updatePassword(user.password);
        }
      }

      // Navigate to the desired screen after successful update
      // You need to implement the navigation logic here

    } catch (e) {
      print('Error updating user data: $e');
      // Handle error appropriately
    }
  } else {
    print('No user found with email: $email');
    // Handle the case where no user is found with the provided email
  }
}

  }