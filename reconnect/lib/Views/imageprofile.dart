import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  // ...
  StorageService() : ref = FirebaseStorage.instance.ref('profileImage');
  final Reference ref;
  String filename = DateTime.now().microsecondsSinceEpoch.toString();
  String imageUrl = '';
  Future<void> uploadfle(String filename, XFile file) async {
    try {
      final imageRef = ref.child(filename);
      final _db = FirebaseFirestore.instance;
      final email = FirebaseAuth.instance.currentUser!.email;

      // Upload the file to Firebase Storage
      final imageBytes = await file.readAsBytes();
      await imageRef.putData(imageBytes);

      // Get the download URL after the image upload is completed
      imageUrl = await imageRef.getDownloadURL();
      print('Image uploaded. URL: $imageUrl');

      // Update the user document in Firestore with the imageUrl
      CollectionReference users = _db.collection('users');
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocRef = querySnapshot.docs.first.reference;
        await userDocRef.update({'imageUrl': imageUrl});
        print('Image URL added to user document successfully.');
      } else {
        print('No user found with the provided email.');
      }
    } catch (e) {
      print('Error uploading image or updating Firestore: $e');
    }
  }
}
