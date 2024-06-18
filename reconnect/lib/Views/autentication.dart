// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:reconnect/Views/authentications/routes/navigation.dart';
// // import 'package:reconnect/Views/authentications/signupcontrollers.dart';
// // import 'package:reconnect/Views/authentications/usermodle.dart';
// // import 'package:reconnect/Views/login.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:reconnect/Views/welcom_page.dart';
// // import 'package:reconnect/Views/resetpassword.dart';
// // class Authentication extends GetxController {
// //   static Authentication get instance => Get.find();
// //   final _auth = FirebaseAuth.instance;
// //   late final Rx<User?> firebaseuser;
// //   final _db = FirebaseFirestore.instance;
// //   final controller = Get.put(SignUpController());
// // final GoogleSignIn googleSignIn = GoogleSignIn();
// //   @override
// //   void onReady() {
// //     firebaseuser = Rx<User?>(_auth.currentUser);
// //     firebaseuser.bindStream(_auth.userChanges());
// //
// //     setInitialScreen(firebaseuser.value);
// //   }
// //
// //   void setInitialScreen(User? user) {
// //     if (user == null) {
// //       Get.offAll(() => const WelcomPage());
// //     } else if (user.emailVerified) {
// //       Get.offAll(() => Navigationpage());
// //     } else {
// //       Get.offAll(() => resetPassword());
// //     }
// //   }
// //
// // //SIGNIN
// //   Future<void> createUserWithEmailAndPassword(
// //       String email, String password) async {
// //     try {
// //       await _auth.createUserWithEmailAndPassword(
// //           email: email, password: password);
// //
// //
// //
// //       final user = UserModel(
// //
// //         firstname: controller.firstname.text.trim(),
// //         lastname: controller.lastname.text.trim(),
// //         email: controller.email.text.trim(),
// //         password: controller.password.text.trim(), imageUrl: 'https://firebasestorage.googleapis.com/v0/b/reconnect-8f8e9.appspot.com/o/profileImage%2Fprofile.jpg?alt=media&token=3fc644e0-6eb9-4145-921e-277327a67e93',
// //       );
// //
// //       SignUpController.instance.creatuser(user);
// //       setInitialScreen(_auth.currentUser);
// //
// //     } on FirebaseAuthException catch (e) {
// //       final errorMessage = _getFirebaseErrorMessage(e);
// //       print("error: $errorMessage");
// //       // Display error in snackbar
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //       throw Exception(errorMessage);
// //     } catch (_) {
// //       const errorMessage = "An error occurred";
// //       print("error: $errorMessage");
// //       // Display error in snackbar
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //     }
// //   }
// //
// //
// //
// //
// //    Future<void> sendverificationemail() async {
// //     try {
// //       await _auth.currentUser?.sendEmailVerification();
// //     } on FirebaseAuthException catch (e) {
// //       final errorMessage = _getFirebaseErrorMessage(e);
// //       print("error: $errorMessage");
// //       // Display error in snackbar
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //       throw Exception(errorMessage);
// //     } catch (_) {
// //       const errorMessage = "An error occurred";
// //       print("error: $errorMessage");
// //       // Display error in snackbar
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //     }
// //   }
// //
// // //LOGIN AND UPDATE FIREBASE
// //
// //
// //
// //   Future<void> logInWithEmailandPassword(String email, String password) async {
// //     try {
// //       await _auth.signInWithEmailAndPassword(email: email, password: password);
// //       final user = _auth.currentUser;
// //       if (user != null) {
// //         await _updateFirestoreEmailAndPassword(email, password);
// //         Get.offAll(() => Navigationpage());
// //
// //       } else {
// //         Get.snackbar('Error', 'Please verify your email.',
// //             snackPosition: SnackPosition.BOTTOM);
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       final errorMessage = _getFirebaseErrorMessage(e);
// //       print('firebase exception - $errorMessage');
// //
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //     } catch (_) {
// //       const errorMessage = "An error occurred";
// //       print("error: $errorMessage");
// //
// //       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //       throw Exception(errorMessage);
// //     }
// //   }
// // //google//////
// //
// //
// // //UPDATE FIREBASE
// //   Future<void> _updateFirestoreEmailAndPassword(
// //       String email, String password) async {
// //     try {
// //       final userSnapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .where('email', isEqualTo: email)
// //           .get();
// //
// //       if (userSnapshot.docs.isNotEmpty) {
// //         final userDoc = userSnapshot.docs.first;
// //         await userDoc.reference.update({
// //           'password': password,
// //         });
// //       }
// //     } catch (e) {
// //       print('Error updating Firestore: $e');
// //       throw Exception('Error updating Firestore: $e');
// //     }
// //   }
// //
// // //REST PASSWORD
// //
// //   Future<void> resetPasswordAndUpdateFirestore(String email) async {
// //     bool emailExists = await checkIfEmailExists(email);
// //
// //     if (emailExists) {
// //       try {
// //         await _auth.sendPasswordResetEmail(email: email);
// //
// //         Get.snackbar("Success", "Password reset email sent",
// //             snackPosition: SnackPosition.BOTTOM);
// //
// //         Get.offAll(() => const login(), duration: const Duration(seconds: 3));
// //       } on FirebaseAuthException catch (e) {
// //         final errorMessage = _getFirebaseErrorMessage(e);
// //         print('Firebase exception - $errorMessage');
// //         // Display error in snackbar
// //         Get.snackbar('Error', errorMessage,
// //             snackPosition: SnackPosition.BOTTOM);
// //       } catch (_) {
// //         const errorMessage = "An error occurred";
// //         print("Error: $errorMessage");
// //         Get.snackbar('Error', errorMessage,
// //             snackPosition: SnackPosition.BOTTOM);
// //       }
// //     } else {
// //       Get.snackbar("Error", "Email not registered",
// //           snackPosition: SnackPosition.BOTTOM);
// //     }
// //   }
// //
// //   //CHECK IF EMAIL EXISTS
// //   Future<bool> checkIfEmailExists(String email) async {
// //     try {
// //       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .where('email', isEqualTo: email)
// //           .get();
// //
// //       return querySnapshot.docs.isNotEmpty;
// //     } catch (error) {
// //       print('Error checking email existence: $error');
// //       return false;
// //     }
// //   }
// //
// //   String _getFirebaseErrorMessage(FirebaseAuthException e) {
// //     switch (e.code) {
// //       case 'email-already-in-use':
// //         return 'The email address is already in use by another account.';
// //       case 'invalid-email':
// //         return 'The email address is not valid.';
// //       case 'operation-not-allowed':
// //         return 'Email/password accounts are not enabled.';
// //       case 'weak-password':
// //         return 'The password is too weak.';
// //       case 'user-disabled':
// //         return 'The user account has been disabled by an administrator.';
// //       case 'user-not-found':
// //         return 'No user found with this email.';
// //       case 'wrong-password':
// //         return 'Wrong password provided for this user.';
// //       default:
// //         return 'An error occurred while processing your request.';
// //     }
// //   }
// //  //Delete
// // Future<void> deleteUserByEmail(String email, String password) async {
// //   try {
// //     // Query Firestore to find the user document with the provided email
// //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //         .collection('users')
// //         .where('email', isEqualTo: email)
// //         .get();
// //
// //     // Check if any documents match the query
// //     if (querySnapshot.docs.isNotEmpty) {
// //       // Get the user document
// //       QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;
// //
// //       // Get the user data
// //       Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
// //
// //       // Verify the password
// //       if (userData != null && userData['password'] == password) {
// //         // Sign in the user with email and password to reauthenticate
// //         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
// //           email: email,
// //           password: password,
// //         );
// //
// //         User? user = userCredential.user;
// //
// //         if (user != null) {
// //           // Delete the user document from Firestore
// //           await FirebaseFirestore.instance
// //               .collection('users')
// //               .doc(userDoc.id)
// //               .delete();
// //
// //           // Delete the user from Firebase Authentication
// //           await user.delete();
// //
// //           // Navigate to the login screen or any other desired destination
// //           Get.offAll(() =>  login());
// //         }
// //       } else {
// //         Get.snackbar('Error', 'Wrong password for: $email',
// //             snackPosition: SnackPosition.BOTTOM);
// //       }
// //     } else {
// //       Get.snackbar('Error', 'No user found with email: $email',
// //           snackPosition: SnackPosition.BOTTOM);
// //     }
// //   } on FirebaseAuthException catch (e) {
// //     // Log the error code and message for debugging purposes
// //     print("FirebaseAuthException code: ${e.code}, message: ${e.message}");
// //
// //     String errorMessage;
// //     switch (e.code) {
// //       case 'user-not-found':
// //         errorMessage = 'No user found for that email.';
// //         break;
// //       case 'wrong-password':
// //         errorMessage = 'Wrong password provided for that user.';
// //         break;
// //       case 'invalid-email':
// //         errorMessage = 'The email address is not valid.';
// //         break;
// //       case 'user-disabled':
// //         errorMessage = 'The user account has been disabled.';
// //         break;
// //       case 'too-many-requests':
// //         errorMessage = 'Too many requests. Try again later.';
// //         break;
// //       default:
// //         errorMessage = e.message ?? 'An unknown error occurred.';
// //     }
// //
// //     Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
// //   } catch (error) {
// //     print("Error deleting user: $error");
// //     Get.snackbar('Error', 'An error occurred: $error',
// //         snackPosition: SnackPosition.BOTTOM);
// //   }
// // }
// //
// //
// //
// //   Future<void> logout() async => await _auth.signOut();
// //
// //
// // }
//
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:reconnect/Views/authentications/routes/navigation.dart';
// import 'package:reconnect/Views/authentications/signupcontrollers.dart';
// import 'package:reconnect/Views/authentications/usermodle.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:reconnect/Views/welcom_page.dart';
// import 'package:reconnect/Views/resetpassword.dart';
// import 'package:reconnect/Views/login.dart';
//
// class Authentication extends GetxController {
//   static Authentication get instance => Get.find();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late final Rx<User?> firebaseUser;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final SignUpController controller = Get.put(SignUpController());
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   @override
//   void onReady() {
//     super.onReady();
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     _setInitialScreen(firebaseUser.value);
//   }
//
//   void _setInitialScreen(User? user) {
//     if (user == null) {
//       Get.offAll(() => const WelcomPage());
//     } else if (user.emailVerified) {
//       Get.offAll(() => Navigationpage());
//     } else {
//       Get.offAll(() => resetPassword());
//     }
//   }
//
//   Future<void> createUserWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//
//       final user = UserModel(
//         firstname: controller.firstName.text.trim(),
//         lastname: controller.lastName.text.trim(),
//         email: controller.email.text.trim(),
//         password: controller.password.text.trim(),
//         imageUrl: 'https://firebasestorage.googleapis.com/v0/b/reconnect-8f8e9.appspot.com/o/profileImage%2Fprofile.jpg?alt=media&token=3fc644e0-6eb9-4145-921e-277327a67e93',
//       );
//
//       SignUpController.instance.createUser(user);
//       _setInitialScreen(_auth.currentUser);
//     } on FirebaseAuthException catch (e) {
//       final errorMessage = _getFirebaseErrorMessage(e);
//       print("error: $errorMessage");
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//       throw Exception(errorMessage);
//     } catch (_) {
//       const errorMessage = "An error occurred";
//       print("error: $errorMessage");
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> sendVerificationEmail() async {
//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       final errorMessage = _getFirebaseErrorMessage(e);
//       print("error: $errorMessage");
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//       throw Exception(errorMessage);
//     } catch (_) {
//       const errorMessage = "An error occurred";
//       print("error: $errorMessage");
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> logInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       final user = _auth.currentUser;
//       if (user != null) {
//         await _updateFirestoreEmailAndPassword(email, password);
//         Get.offAll(() => Navigationpage());
//       } else {
//         Get.snackbar('Error', 'Please verify your email.', snackPosition: SnackPosition.BOTTOM);
//       }
//     } on FirebaseAuthException catch (e) {
//       final errorMessage = _getFirebaseErrorMessage(e);
//       print('firebase exception - $errorMessage');
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } catch (_) {
//       const errorMessage = "An error occurred";
//       print("error: $errorMessage");
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//       throw Exception(errorMessage);
//     }
//   }
//
//   Future<void> _updateFirestoreEmailAndPassword(String email, String password) async {
//     try {
//       final userSnapshot = await _db.collection('users').where('email', isEqualTo: email).get();
//
//       if (userSnapshot.docs.isNotEmpty) {
//         final userDoc = userSnapshot.docs.first;
//         await userDoc.reference.update({'password': password});
//       }
//     } catch (e) {
//       print('Error updating Firestore: $e');
//       throw Exception('Error updating Firestore: $e');
//     }
//   }
//
//   Future<void> resetPasswordAndUpdateFirestore(String email) async {
//     bool emailExists = await checkIfEmailExists(email);
//
//     if (emailExists) {
//       try {
//         await _auth.sendPasswordResetEmail(email: email);
//         Get.snackbar("Success", "Password reset email sent", snackPosition: SnackPosition.BOTTOM);
//         Get.offAll(() => const login(), duration: const Duration(seconds: 3));
//       } on FirebaseAuthException catch (e) {
//         final errorMessage = _getFirebaseErrorMessage(e);
//         print('Firebase exception - $errorMessage');
//         Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//       } catch (_) {
//         const errorMessage = "An error occurred";
//         print("Error: $errorMessage");
//         Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar("Error", "Email not registered", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<bool> checkIfEmailExists(String email) async {
//     try {
//       QuerySnapshot querySnapshot = await _db.collection('users').where('email', isEqualTo: email).get();
//       return querySnapshot.docs.isNotEmpty;
//     } catch (error) {
//       print('Error checking email existence: $error');
//       return false;
//     }
//   }
//
//   String _getFirebaseErrorMessage(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'email-already-in-use':
//         return 'The email address is already in use by another account.';
//       case 'invalid-email':
//         return 'The email address is not valid.';
//       case 'operation-not-allowed':
//         return 'Email/password accounts are not enabled.';
//       case 'weak-password':
//         return 'The password is too weak.';
//       case 'user-disabled':
//         return 'The user account has been disabled by an administrator.';
//       case 'user-not-found':
//         return 'No user found with this email.';
//       case 'wrong-password':
//         return 'Wrong password provided for this user.';
//       default:
//         return 'An error occurred while processing your request.';
//     }
//   }
//
//   Future<void> deleteUserByEmail(String email, String password) async {
//     try {
//       QuerySnapshot querySnapshot = await _db.collection('users').where('email', isEqualTo: email).get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;
//         Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
//
//         if (userData != null && userData['password'] == password) {
//           UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//
//           User? user = userCredential.user;
//
//           if (user != null) {
//             await _db.collection('users').doc(userDoc.id).delete();
//             await user.delete();
//             Get.offAll(() => login());
//           }
//         } else {
//           Get.snackbar('Error', 'Wrong password for: $email', snackPosition: SnackPosition.BOTTOM);
//         }
//       } else {
//         Get.snackbar('Error', 'No user found with email: $email', snackPosition: SnackPosition.BOTTOM);
//       }
//     } on FirebaseAuthException catch (e) {
//       print("FirebaseAuthException code: ${e.code}, message: ${e.message}");
//       String errorMessage = _getFirebaseErrorMessage(e);
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } catch (error) {
//       print("Error deleting user: $error");
//       Get.snackbar('Error', 'An error occurred: $error', snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> logout() async => await _auth.signOut();
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reconnect/Views/authentications/routes/navigation.dart';
import 'package:reconnect/Views/authentications/signupcontrollers.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reconnect/Views/vrification_email.dart';
import 'package:reconnect/Views/welcom_page.dart';

import 'package:reconnect/Views/login.dart';

class Authentication extends GetxController {
  static Authentication get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final SignUpController controller = Get.put(SignUpController());
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(firebaseUser.value);
  }

  void setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const WelcomPage());
    } else if (user.emailVerified) {
      Get.offAll(() => const Navigationpage());
    } else {
      Get.offAll(() => const verification());
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final user = UserModel(
        firstname: controller.firstName.text.trim(),
        lastname: controller.lastName.text.trim(),
        email: controller.email.text.trim(),
        password: controller.password.text.trim(),
        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/reconnect-8f8e9.appspot.com/o/profileImage%2Fprofile.jpg?alt=media&token=3fc644e0-6eb9-4145-921e-277327a67e93',
      );

      SignUpController.instance.createUser(user);
      setInitialScreen(_auth.currentUser);
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print("error: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print("error: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      if (user != null) {
        await _updateFirestoreEmailAndPassword(email, password);
        Get.offAll(() => const Navigationpage());
      } else {
        Get.snackbar('Error', 'Please verify your email.', snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print('firebase exception - $errorMessage');
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    }
  }

  Future<void> _updateFirestoreEmailAndPassword(String email, String password) async {
    try {
      final userSnapshot = await _db.collection('users').where('email', isEqualTo: email).get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs.first;
        await userDoc.reference.update({'password': password});
      }
    } catch (e) {
      print('Error updating Firestore: $e');
      throw Exception('Error updating Firestore: $e');
    }
  }

  Future<void> resetPasswordAndUpdateFirestore(String email) async {
    bool emailExists = await checkIfEmailExists(email);

    if (emailExists) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        Get.snackbar("Success", "Password reset email sent", snackPosition: SnackPosition.BOTTOM);
        Get.offAll(() => const login(), duration: const Duration(seconds: 3));
      } on FirebaseAuthException catch (e) {
        final errorMessage = _getFirebaseErrorMessage(e);
        print('Firebase exception - $errorMessage');
        Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      } catch (_) {
        const errorMessage = "An error occurred";
        print("Error: $errorMessage");
        Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Error", "Email not registered", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('users').where('email', isEqualTo: email).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error checking email existence: $error');
      return false;
    }
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided for this user.';
      default:
        return 'An error occurred while processing your request.';
    }
  }

  Future<void> deleteUserByEmail(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('users').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null && userData['password'] == password) {
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
          User? user = userCredential.user;

          if (user != null) {
            await _db.collection('users').doc(userDoc.id).delete();
            await user.delete();
            Get.offAll(() => const login());
          }
        } else {
          Get.snackbar('Error', 'Wrong password for: $email', snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'No user found with email: $email', snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException code: ${e.code}, message: ${e.message}");
      String errorMessage = _getFirebaseErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print("Error deleting user: $error");
      Get.snackbar('Error', 'An error occurred: $error', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<Map<String, dynamic>> getUserInformation() async {
    Map<String, dynamic> userInfo = {};

    try {
      // Get current user from FirebaseAuth
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Get user document from Firestore using the user's UID
        DocumentSnapshot userDoc =
        await _db.collection('users').doc(currentUser.uid).get();

        if (userDoc.exists) {
          // Extract user information from the document
          userInfo['email'] = currentUser.email;
          userInfo['firstName'] = userDoc['firstname'];
          userInfo['lastName'] = userDoc['lastname'];
        }
      }
    } catch (e) {
      // Handle any errors that may occur
      print('Error getting user information: $e');
    }

    return userInfo;
  }
}
