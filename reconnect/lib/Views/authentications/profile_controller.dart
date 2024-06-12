// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:reconnect/Views/autentication.dart';
// import 'package:reconnect/Views/authentications/user_repo.dart';
// import 'package:reconnect/Views/authentications/usermodle.dart';
// import 'package:reconnect/Views/profile.dart';
//
// class Profilecontroller extends GetxController {
//   static Profilecontroller get to => Get.find();
//
//
//   final _authrepo = Get.put(Authentication());
//   final _userrepo = Get.put(User_report());
//
//   getuserdata() {
//     final email = _authrepo.firebaseuser.value?.email;
//     if (email != null) {
//       return _userrepo.getuserdata(email);
//     } else {
//       Get.snackbar("error", "login to continue");
//     }
//     // final name=_authrepo.firebaseuser.value.displayName;
//     // final image=_authrepo.firebaseuser.value.photoURL;
//     // final uid=_authrepo.firebaseuser.value.uid;
//     // final phone=_authrepo.firebaseuser.value.phoneNumber;
//     // final email=_authrepo.firebaseuser.value.email;
//     // final name=_authrepo.firebaseuser.value.displayName;
//   }
//
//   //updateRecord(UserModel user) async {
//     //await _userrepo.updateUserData(user);
//   //}
//
//
//
//    Future<void> updateRecord(UserModel user, {bool updateAuth = false}) async {
//
//   final email = FirebaseAuth.instance.currentUser!.email;
//
//
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where('email', isEqualTo: email)
//       .get();
//
//   // Check if any documents match the query
//   if (querySnapshot.docs.isNotEmpty) {
//     // Get the user document
//     QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;
//
//     // Get the user ID
//     String userId = userDoc.id;
//
//     try {
//       // Update the user document in Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .update(user.toJson());
//
//       // Update user's email and password in Firebase Authentication if needed
//       if (updateAuth) {
//         // Update email if it has changed
//         if (user.email != email) {
//           await FirebaseAuth.instance.currentUser!.updateEmail(user.email);
//         }
//
//         // Update password if it has changed
//         if (user.password != null && user.password.isNotEmpty) {
//           await FirebaseAuth.instance.currentUser!.updatePassword(user.password);
//         }
//       }
//       Get.offAll(() => profile());
//
//
//     } catch (e) {
//       print('Error updating user data: $e');
//
//     }
//   } else {
//     print('No user found with email: $email');
//
//   }
// }
//
//   }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';
import 'package:reconnect/Views/authentications/user_repo.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:reconnect/Views/profile.dart';

class Profilecontroller extends GetxController {
  static Profilecontroller get to => Get.find();

  final _authRepo = Get.put(Authentication());
  final _userRepo = Get.put(User_report());

  Future<UserModel?> getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      try {
        return await _userRepo.getUserData(email);
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch user data: $e");
        return null;
      }
    } else {
      Get.snackbar("Error", "Please log in to continue");
      return null;
    }
  }

  Future<void> updateRecord(UserModel user, {bool updateAuth = false}) async {
    final email = FirebaseAuth.instance.currentUser!.email;

    if (email == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;
      String userId = userDoc.id;

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update(user.toJson());

        if (updateAuth) {
          if (user.email != email) {
            await FirebaseAuth.instance.currentUser!.updateEmail(user.email);
          }

          if (user.password.isNotEmpty) {
            await FirebaseAuth.instance.currentUser!.updatePassword(user.password);
          }
        }
        Get.offAll(() => const profile());
      } catch (e) {
        Get.snackbar("Error", "Failed to update user data: $e");
      }
    } else {
      Get.snackbar("Error", "No user found with email: $email");
    }
  }
}
