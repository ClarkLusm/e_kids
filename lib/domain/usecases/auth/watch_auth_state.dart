import '../../models/app_user.dart';
import '../../repositories/auth_repository.dart';

class WatchAuthState {
  final AuthRepository _repo;
  WatchAuthState(this._repo);
  Stream<AppUser?> call() => _repo.watchAuthState();
}
