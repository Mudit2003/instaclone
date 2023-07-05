import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instaclone/firebase_options.dart';
import 'package:instaclone/models/auth/auth_exceptions.dart';
import 'package:instaclone/models/auth/auth_provider.dart';
import 'package:instaclone/models/auth/auth_user.dart';
import 'package:instaclone/models/auth/auth_user_profile.dart';
import 'package:instaclone/models/cloud/cloud_user.dart';
import 'package:instaclone/models/cloud/firebase_cloud_storage.dart';

class FirebaseAuthProvider implements AuthProvider {
  final _cloudInstance = FirebaseCloud();
  @override
  AuthUser? get currentUser {
    // what about the user profile detatils
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InavalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      AuthUserProfile().profileSetter = null;
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (_) {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> register(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InavalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InavalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<UserProfile> createProfile({
    required String bio,
    required String name,
    required String username,
  }) async {
    final user = currentUser;
    try {
      if (await _cloudInstance.isUserNamePossible(
        username: username,
      )) {
        _cloudInstance.createNewUserProfile(
            profile: UserProfile(
              userName: username,
              name: name,
              bio: bio,
              followers: [],
              followings: [],
            ),
            uId: user!.id);
      } else {
        throw UserNameNotPossibleAuthException();
      }
    } catch (e) {
      log("Exception: ${e.toString()}");
      rethrow;
    }

    return UserProfile(
      userName: username,
      name: name,
      bio: bio,
      followers: [],
      followings: [],
    );
  }

  @override
  Future<bool> isUsernamePossible({required String username}) {
    return _cloudInstance.isUserNamePossible(username: username);
  }

  @override
  Future<UserProfile?> get profile async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UserNotLoggedInAuthException();
    }
    try {
      final authProfile = AuthUserProfile();
      final userProfile = authProfile.profileGetter ??
          await _cloudInstance.profileExists(
            userId: user.uid,
          );
      if (userProfile != null) {
        authProfile.profileSetter = userProfile;
        return userProfile;
      } else {
        return null;
      }
    } on Exception {
      throw UserNotFoundAuthException();
    }
  }
}
