import '../models/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> watchAuthState();
  AppUser? get currentUser;
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> updateProfile({
    required String displayName,
    required String avatarId,
  });
  Future<void> signOut();
}
