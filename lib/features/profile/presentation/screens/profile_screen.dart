import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:e_kids/features/home/presentation/providers/learning_summary_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _blue = Color(0xFF05A7F2);
  static const _navy = Color(0xFF063B82);
  static const _yellow = Color(0xFFFFD22E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final summary = ref.watch(homeLearningSummaryProvider).valueOrNull;
    final childName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'Bạn nhỏ';
    final avatar = _avatarEmoji(user?.avatarId);

    return Scaffold(
      backgroundColor: const Color(0xFFE7F8FF),
      appBar: AppBar(
        title: const Text('Hồ sơ của bé'),
        backgroundColor: _blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 130),
          children: [
            _ProfileHero(
              childName: childName,
              avatar: avatar,
              level: summary?.level ?? 1,
              totalXp: summary?.totalXp ?? 0,
            ),
            const SizedBox(height: 16),
            _ProfileActionCard(
              icon: Icons.child_care,
              title: 'Đổi nhân vật của bé',
              subtitle: 'Chọn lại avatar hoặc cập nhật tên bé.',
              color: const Color(0xFF22C55E),
              onTap: () => context.push(Routes.selectProfile),
            ),
            const SizedBox(height: 12),
            _ProfileActionCard(
              icon: Icons.lock,
              title: 'Chuyển sang tài khoản ba mẹ',
              subtitle: 'Cần nhập mã PIN 6 số để mở Parent Zone.',
              color: const Color(0xFFF97316),
              onTap: () => _openParentZone(context),
            ),
          ],
        ),
      ),
    );
  }

  void _openParentZone(BuildContext context) {
    context.push(Routes.parentPin);
  }

  String _avatarEmoji(String? avatarId) {
    return switch (avatarId) {
      'lion' => '🦁',
      'rabbit' => '🐰',
      'cat' => '🐱',
      'panda' => '🐼',
      'fox' => '🦊',
      'bear' => '🐻',
      _ => '🐶',
    };
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.childName,
    required this.avatar,
    required this.level,
    required this.totalXp,
  });

  final String childName;
  final String avatar;
  final int level;
  final int totalXp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF16B4FF), Color(0xFF86E7FF)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white, width: 5),
        boxShadow: const [BoxShadow(color: Color(0x22003477), blurRadius: 14)],
      ),
      child: Column(
        children: [
          Container(
            width: 118,
            height: 118,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProfileScreen._yellow,
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Text(avatar, style: const TextStyle(fontSize: 66)),
          ),
          const SizedBox(height: 14),
          Text(
            childName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              shadows: [Shadow(color: Color(0xAA004A96), blurRadius: 4)],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatPill(label: 'Level', value: '$level'),
              const SizedBox(width: 10),
              _StatPill(label: 'XP', value: '$totalXp'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: const TextStyle(
          color: ProfileScreen._navy,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ProfileActionCard extends StatelessWidget {
  const _ProfileActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(color: Color(0x16000000), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: ProfileScreen._navy,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, height: 1.25),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: ProfileScreen._navy),
          ],
        ),
      ),
    );
  }
}
