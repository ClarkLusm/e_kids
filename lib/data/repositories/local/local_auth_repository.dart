import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/app_user.dart';
import '../../../domain/repositories/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  static const _userIdKey = 'local_user_id';
  static const _displayNameKey = 'local_display_name';
  static const _avatarIdKey = 'local_avatar_id';

  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> watchAuthState() async* {
    _currentUser = await _loadUser();
    yield _currentUser;
    yield* _controller.stream;
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
    final prefs = await SharedPreferences.getInstance();
    final userId = _currentUser?.id ?? 'local_child';

    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_displayNameKey, displayName);
    await prefs.setString(_avatarIdKey, avatarId);

    _currentUser = AppUser(
      id: userId,
      displayName: displayName,
      avatarId: avatarId,
    );
    _controller.add(_currentUser);
  }

  @override
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_displayNameKey);
    await prefs.remove(_avatarIdKey);

    _currentUser = null;
    _controller.add(null);
  }

  Future<AppUser?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final displayName = prefs.getString(_displayNameKey);
    final avatarId = prefs.getString(_avatarIdKey);

    if (displayName == null ||
        displayName.trim().isEmpty ||
        avatarId == null ||
        avatarId.trim().isEmpty) {
      return null;
    }

    return AppUser(
      id: prefs.getString(_userIdKey) ?? 'local_child',
      displayName: displayName,
      avatarId: avatarId,
    );
  }
}
