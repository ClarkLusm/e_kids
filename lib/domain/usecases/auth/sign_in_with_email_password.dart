import '../../repositories/auth_repository.dart';

class SignInWithEmailPassword {
  final AuthRepository _repo;
  const SignInWithEmailPassword(this._repo);

  Future<void> call({required String email, required String password}) {
    return _repo.signInWithEmailPassword(email: email, password: password);
  }
}
