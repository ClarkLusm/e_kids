import '../../repositories/auth_repository.dart';

class SignUpWithEmailPassword {
  final AuthRepository _repo;
  const SignUpWithEmailPassword(this._repo);

  Future<bool> call({required String email, required String password}) {
    return _repo.signUpWithEmailPassword(email: email, password: password);
  }
}
