import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/app_user.dart';

extension UserMapper on User {
  AppUser toDomain() => AppUser(
    id: id,
    email: email,
    displayName: userMetadata?['display_name'] as String?,
    avatarId: userMetadata?['avatar_id'] as String?,
  );
}
