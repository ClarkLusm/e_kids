import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/database/database_providers.dart';
import '../../../../data/datasources/remote/auth_remote_datasource.dart';
import '../../../../data/repositories/local/local_auth_repository.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/models/app_user.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/usecases/auth/sign_in_with_email_password.dart';
import '../../../../domain/usecases/auth/sign_up_with_email_password.dart';
import '../../../../domain/usecases/auth/update_profile.dart';
import '../../../../domain/usecases/auth/watch_auth_state.dart';

// TODO(api): bật `useRemoteAuthProvider` khi chuyển sang Supabase Auth thật.
final useRemoteAuthProvider = Provider<bool>((ref) => false);

// client dùng chung cho phase API.
final supabaseProvider = Provider((ref) => Supabase.instance.client);

// datasource
final authRemoteDataSourceProvider = Provider((ref) {
  return AuthRemoteDataSource(ref.watch(supabaseProvider));
});

// repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final useRemote = ref.watch(useRemoteAuthProvider);
  if (!useRemote) {
    return LocalAuthRepository(ref.watch(appDatabaseProvider));
  }

  // TODO(api): repository này đã sẵn sàng cho Supabase, chỉ cần bật flag
  // và khởi tạo Supabase ở main.dart khi làm phase API.
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

// usecase
final watchAuthStateProvider = Provider((ref) {
  return WatchAuthState(ref.watch(authRepositoryProvider));
});

final signInWithEmailPasswordProvider = Provider((ref) {
  return SignInWithEmailPassword(ref.watch(authRepositoryProvider));
});

final signUpWithEmailPasswordProvider = Provider((ref) {
  return SignUpWithEmailPassword(ref.watch(authRepositoryProvider));
});

final updateProfileProvider = Provider((ref) {
  return UpdateProfile(ref.watch(authRepositoryProvider));
});

// STREAM mà router sẽ watch
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(watchAuthStateProvider).call();
});

final authActionControllerProvider =
    AsyncNotifierProvider<AuthActionController, void>(AuthActionController.new);

class AuthActionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(signInWithEmailPasswordProvider)
          .call(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      final hasSession = await ref
          .read(signUpWithEmailPasswordProvider)
          .call(email: email, password: password);
      state = const AsyncData(null);
      return hasSession;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> saveProfile({
    required String displayName,
    required String avatarId,
  }) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(updateProfileProvider)
          .call(displayName: displayName, avatarId: avatarId);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
