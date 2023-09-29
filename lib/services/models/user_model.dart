import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? name;
  final String? email;
  final int? phone;

  UserModel({required this.name, required this.email, required this.phone});

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "state": email,
      if (phone != null) "country": phone,
    };
  }

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      email: data?['email'],
      phone: data?['phone'],

    );
  }
}