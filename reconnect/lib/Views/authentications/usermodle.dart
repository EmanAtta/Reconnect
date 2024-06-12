


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String imageUrl;

  const UserModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      firstname: data['firstname'] ?? '',
      lastname: data['lastname'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  String get fullName => '$firstname $lastname';
}



