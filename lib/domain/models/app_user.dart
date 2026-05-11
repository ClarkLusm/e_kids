class AppUser {
  final String id;
  final String? email;
  final String? displayName;
  final String? avatarId;

  const AppUser({
    required this.id,
    this.email,
    this.displayName,
    this.avatarId,
  });

  bool get hasSelectedProfile =>
      displayName != null && displayName!.trim().isNotEmpty;
}
