import 'package:instaclone/models/cloud/cloud_user.dart';

import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;

  Future<UserProfile?> get profile;

  Future<bool> isUsernamePossible({
    required String username,
  });

  Future<UserProfile> createProfile({
    required String username,
    required String bio,
    required String name,
  });

  Future<AuthUser> logIn({
    required final String email,
    required final String password,
  });

  Future<void> register({
    required final String email,
    required final String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({
    required String toEmail,
  });
}
