import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:e_kids/features/lesson/domain/models/lesson_models.dart';
import 'package:e_kids/features/lesson/presentation/providers/lesson_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeLearningSummaryProvider =
    FutureProvider.autoDispose<HomeLearningSummary>((ref) async {
      final childId = ref.watch(currentChildIdProvider);
      final progressMap = await ref
          .watch(lessonProgressDaoProvider)
          .getProgressByChild(childId);
      return HomeLearningSummary.fromProgress(progressMap.values);
    });

class HomeLearningSummary {
  const HomeLearningSummary({
    required this.totalXp,
    required this.completedLessons,
  });

  final int totalXp;
  final int completedLessons;

  static const empty = HomeLearningSummary(totalXp: 0, completedLessons: 0);

  factory HomeLearningSummary.fromProgress(
    Iterable<LessonProgress> progressItems,
  ) {
    var totalXp = 0;
    var completedLessons = 0;

    for (final progress in progressItems) {
      totalXp += progress.totalXpEarned;
      if (progress.isDone) {
        completedLessons++;
      }
    }

    return HomeLearningSummary(
      totalXp: totalXp,
      completedLessons: completedLessons,
    );
  }

  int get level => (totalXp ~/ 100) + 1;
  int get nextLevel => level + 1;
  double get levelProgress => ((totalXp % 100) / 100).clamp(0.0, 1.0);
  int get levelProgressPercent => (levelProgress * 100).round();
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // Màu từ tailwind.config
  static const kidBlue = Color(0xFF3B82F6);
  static const kidYellow = Color(0xFFEAB308);
  static const kidOrange = Color(0xFFF97316);
  static const kidGreen = Color(0xFF10B981);
  static const kidPink = Color(0xFFEC4899);
  static const bgBlue = Color(0xFFEFF6FF); // blue-50

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final childName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'Bạn';
    final avatar = _avatarEmoji(user?.avatarId);
    final summary =
        ref.watch(homeLearningSummaryProvider).valueOrNull ??
        HomeLearningSummary.empty;

    return Scaffold(
      backgroundColor: bgBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBar(
                    childName: childName,
                    avatar: avatar,
                    level: summary.level,
                    totalXp: summary.totalXp,
                  ),
                  const SizedBox(height: 24),
                  _progressSection(summary),
                  const SizedBox(height: 24),
                  _continueCard(context),
                  const SizedBox(height: 32),
                  _topicGrid(),
                  const SizedBox(height: 32),
                  _leaderboard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar({
    required String childName,
    required String avatar,
    required int level,
    required int totalXp,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kidYellow,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              alignment: Alignment.center,
              child: Text(avatar, style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CẤP ĐỘ $level',
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: kidBlue,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Chào, $childName!',
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: kidYellow, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Row(
            children: [
              const Icon(Icons.stars, color: kidYellow, size: 28),
              const SizedBox(width: 6),
              Text(
                '$totalXp XP',
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: kidYellow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _avatarEmoji(String? avatarId) {
    return switch (avatarId) {
      'lion' => '🦁',
      'rabbit' => '🐰',
      'cat' => '🐱',
      'panda' => '🐼',
      'fox' => '🦊',
      'bear' => '🐻',
      _ => '👦',
    };
  }

  Widget _progressSection(HomeLearningSummary summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFDBEAFE), width: 2),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiến độ hiện tại',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF334155),
                    ),
                  ),
                  Text(
                    '${summary.levelProgressPercent}% tới Cấp ${summary.nextLevel}',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: kidBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: summary.levelProgress,
                    child: Container(
                      height: 24,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFF43F5E)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(999)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFFECACA), width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('📚', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                '${summary.completedLessons} bài đã hoàn thành',
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFDC2626),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _continueCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6CCFFF), Color(0xFFA78BFA)],
        ),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 16)],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'HÀNH TRÌNH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4F46E5),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tiếp tục học',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bài 3: Động vật · Phần 4/8',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kidYellow,
                  foregroundColor: const Color(0xFF1E293B),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black26,
                  side: const BorderSide(color: Color(0xFFFDE047), width: 4),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 32),
                    SizedBox(width: 8),
                    Text(
                      'Bắt đầu',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            right: -8,
            bottom: -8,
            child: Text('🦁', style: TextStyle(fontSize: 120)),
          ),
        ],
      ),
    );
  }

  Widget _topicGrid() {
    final topics = [
      ('Động vật', '🐾', const Color(0xFFDBEAFE), const Color(0xFFBFDBFE)),
      ('Thức ăn', '🍎', const Color(0xFFFEE2E2), const Color(0xFFFECACA)),
      ('Nhà cửa', '🏠', const Color(0xFFDCFCE7), const Color(0xFFBBF7D0)),
      ('Màu sắc', '🎨', const Color(0xFFF3E8FF), const Color(0xFFE9D5FF)),
      ('Xe cộ', '🚗', const Color(0xFFFEF9C3), const Color(0xFFFEF08A)),
      (
        'Gia đình',
        '👨‍👩‍👧',
        const Color(0xFFFCE7F3),
        const Color(0xFFFBCFE8),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Khám phá chủ đề',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: topics.length,
          itemBuilder: (context, i) {
            final t = topics[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: t.$3, width: 4),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: t.$4,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(t.$2, style: const TextStyle(fontSize: 36)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.$1,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _leaderboard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFDBEAFE), width: 4),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bảng xếp hạng',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Tất cả',
                  style: TextStyle(
                    color: kidBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _leaderRow(1, '👧', 'Sarah L.', '410 XP', false),
          const SizedBox(height: 12),
          _leaderRow(2, '👦', 'Bạn (Minh)', '320 XP', true),
        ],
      ),
    );
  }

  Widget _leaderRow(int rank, String emoji, String name, String xp, bool isMe) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? kidYellow.withOpacity(0.2) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isMe ? kidYellow : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: rank == 1 ? kidYellow : Colors.grey,
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFDBEAFE) : const Color(0xFFFFEDD5),
              shape: BoxShape.circle,
              border: Border.all(color: isMe ? kidBlue : kidOrange, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            xp,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w900,
              color: kidBlue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
