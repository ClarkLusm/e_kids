import '../../repositories/auth_repository.dart';

class UpdateProfile {
  final AuthRepository _repo;
  const UpdateProfile(this._repo);

  Future<void> call({required String displayName, required String avatarId}) {
    return _repo.updateProfile(displayName: displayName, avatarId: avatarId);
  }
}
