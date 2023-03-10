import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/services/cloud/auth_cloud_constatnts.dart';

class AuthCloud {
  final String userId;
  final String name;
  final String email;
  final String bio;
  final String userName;

  AuthCloud({
    required this.userId,
    required this.userName,
    required this.name,
    required this.email,
    required this.bio,
  });

  AuthCloud.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : userId = snapshot.id,
        userName = snapshot.data()[userNameField] as String,
        bio = snapshot.data()[ownerBioField] as String,
        email = snapshot.data()[emailField] as String,
        name = snapshot.data()[nameField] as String;
}
