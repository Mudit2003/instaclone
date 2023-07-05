import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaclone/models/auth/auth_user_profile.dart';

class AuthUser {
  final String email;
  final String id;
  final bool isEmailVerified;
  AuthUserProfile? profile;

  set profileSetter(AuthUserProfile currUserProfile) {
    profile = currUserProfile;
  }

  AuthUser({
    required this.email,
    required this.id,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email!, // force unwrap
        id: user.uid,
        isEmailVerified: user.emailVerified,
      );
}
