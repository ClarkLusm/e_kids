import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  AuthRepositoryImpl(this._remote);

  @override
  Stream<AppUser?> watchAuthState() {
    return _remote.authStateChanges().map((u) => u?.toDomain()).distinct();
  }

  @override
  AppUser? get currentUser => _remote.client.auth.currentUser?.toDomain();

  @override
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _remote.signInWithEmailPassword(email: email, password: password);
  }

  @override
  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _remote.signUpWithEmailPassword(email: email, password: password);
  }

  @override
  Future<void> updateProfile({
    required String displayName,
    required String avatarId,
  }) {
    return _remote.updateUserProfile(
      displayName: displayName,
      avatarId: avatarId,
    );
  }

  @override
  Future<void> signOut() => _remote.client.auth.signOut();
}
