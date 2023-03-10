import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
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
