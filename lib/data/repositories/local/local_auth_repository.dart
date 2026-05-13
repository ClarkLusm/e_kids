import '../../../core/database/app_database.dart';
import '../../../core/database/daos/child_profiles_dao.dart';
import '../../../domain/models/app_user.dart';
import '../../../domain/repositories/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(AppDatabase database)
    : _profilesDao = ChildProfilesDao(database);

  final ChildProfilesDao _profilesDao;
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> watchAuthState() {
    return _profilesDao.watchActiveProfile().map((user) {
      _currentUser = user;
      return user;
    });
  }

  @override
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // TODO(api): unused in local onboarding. Keep contract for API auth phase.
  }

  @override
  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // TODO(api): unused in local onboarding. Keep contract for API auth phase.
    return true;
  }

  @override
  Future<void> updateProfile({
    required String displayName,
    required String avatarId,
  }) async {
    final userId = _currentUser?.id ?? 'local_child';
    await _profilesDao.upsertProfile(
      id: userId,
      name: displayName,
      avatarId: avatarId,
    );

    _currentUser = AppUser(
      id: userId,
      displayName: displayName,
      avatarId: avatarId,
    );
  }

  @override
  Future<void> signOut() async {
    await _profilesDao.clearProfiles();
    _currentUser = null;
  }
}
