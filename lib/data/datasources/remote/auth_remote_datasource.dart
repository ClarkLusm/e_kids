import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient client;
  AuthRemoteDataSource(this.client);

  Stream<User?> authStateChanges() {
    return client.auth.onAuthStateChange.map((e) => e.session?.user);
  }

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = await client.auth.signUp(email: email, password: password);
    return res.session != null;
  }

  Future<void> updateUserProfile({
    required String displayName,
    required String avatarId,
  }) async {
    await client.auth.updateUser(
      UserAttributes(
        data: <String, dynamic>{
          'display_name': displayName,
          'avatar_id': avatarId,
        },
      ),
    );
  }
}
