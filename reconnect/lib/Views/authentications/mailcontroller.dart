// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:reconnect/Views/autentication.dart';
//
// class MailVerificationController extends GetxController {
//   late Timer _timer;
//
//   @override
//   void onInit() {
//     super.onInit();
//     sendVerificationMail();
//     startRedirectTimer();
//   }
//
//   @override
//   void onClose() {
//     _timer.cancel();
//     super.onClose();
//   }
//
//   void sendVerificationMail() async {
//     try {
//       await Authentication.instance.sendVerificationEmail();
//     } catch (e) {
//       print(e);
//       Get.snackbar('Error', 'Failed to send verification email: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   void startRedirectTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
//       await FirebaseAuth.instance.currentUser?.reload();
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null && user.emailVerified) {
//         timer.cancel();
//         Authentication.instance._setInitialScreen(user);
//       }
//     });
//   }
//
//   void checkVerification() async {
//     await FirebaseAuth.instance.currentUser?.reload();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null && user.emailVerified) {
//       _timer.cancel();
//       Authentication.instance._setInitialScreen(user);
//     }
//   }
// }



import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVerificationMail();
    startRedirectTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void sendVerificationMail() async {
    try {
      await Authentication.instance.sendVerificationEmail();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to send verification email: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void startRedirectTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        timer.cancel();
        Authentication.instance.setInitialScreen(user);
      }
    });
  }

  void checkVerification() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      _timer.cancel();
      Authentication.instance.setInitialScreen(user);
    }
  }
}
