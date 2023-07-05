import 'package:instaclone/models/auth/auth_provider.dart';
import 'package:instaclone/models/auth/auth_user.dart';

class AuthService {
  final AuthProvider provider;

  AuthService(this.provider);

  Future<void> initialize() => provider.initialize();
  AuthUser? get currentUser => provider.currentUser;
  Future<void> register({
    required String email,
    required String password,
  }) =>
      provider.register(
        email: email,
        password: password,
      );

  Future<void> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  Future<void> logOut() => provider.logOut();

  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  Future<void> sendPasswordReset({required String email}) =>
      provider.sendPasswordResetEmail(toEmail: email);

  Future<void> createUserProfile({
    required String name,
    required String username,
    required String bio,
  }) async =>
      provider.createProfile(
        username: username,
        bio: bio,
        name: name,
      );
}
