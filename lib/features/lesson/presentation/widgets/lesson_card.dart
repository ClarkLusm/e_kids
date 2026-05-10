import 'package:flutter/material.dart';
import '../../domain/models/lesson_models.dart';

/// Card bài học trong danh sách — hiện tiêu đề, trạng thái, sao và loại quiz.
class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress? progress;
  final VoidCallback? onTap;

  const LessonCard({
    required this.lesson,
    this.progress,
    this.onTap,
    super.key,
  });

  LessonStatus get _status => progress?.status ?? LessonStatus.locked;

  bool get _isLocked => _status == LessonStatus.locked;

  bool get _isDone =>
      _status == LessonStatus.completed || _status == LessonStatus.mastered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLocked ? null : onTap,
      child: AnimatedOpacity(
        opacity: _isLocked ? 0.55 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _borderColor,
              width:
                  _status == LessonStatus.unlocked ||
                      _status == LessonStatus.inProgress
                  ? 2
                  : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Thumbnail hoặc icon
                _ThumbnailBox(
                  thumbnailUrl: lesson.thumbnailUrl,
                  status: _status,
                  level: lesson.level,
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + status badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lesson.titleVi,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _isLocked
                                    ? Colors.grey
                                    : const Color(0xFF1A1A2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _StatusBadge(status: _status),
                        ],
                      ),
                      const SizedBox(height: 3),

                      // Subtitle
                      if (lesson.descriptionVi != null)
                        Text(
                          lesson.descriptionVi!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 6),

                      // Meta: vocab count + XP + stars
                      Row(
                        children: [
                          _MetaChip(
                            icon: Icons.book_outlined,
                            label: '${lesson.vocabularyCount} từ',
                          ),
                          const SizedBox(width: 6),
                          _MetaChip(
                            icon: Icons.bolt_rounded,
                            label: '+${lesson.xpReward} XP',
                            color: const Color(0xFF534AB7),
                          ),
                          const Spacer(),
                          // Sao nếu đã làm
                          if (_isDone && progress != null)
                            _StarRow(stars: progress!.stars),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                if (!_isLocked)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _borderColor => switch (_status) {
    LessonStatus.unlocked => const Color(0xFF534AB7),
    LessonStatus.inProgress => const Color(0xFFEF9F27),
    LessonStatus.completed => const Color(0xFF1D9E75),
    LessonStatus.mastered => const Color(0xFFEF9F27),
    LessonStatus.locked => Colors.grey.shade200,
  };
}

// ─── Thumbnail box ────────────────────────────────────────────────────────

class _ThumbnailBox extends StatelessWidget {
  final String? thumbnailUrl;
  final LessonStatus status;
  final int level;

  const _ThumbnailBox({
    required this.thumbnailUrl,
    required this.status,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = status == LessonStatus.locked;
    final isDone =
        status == LessonStatus.completed || status == LessonStatus.mastered;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: isLocked
            ? Colors.grey.shade100
            : isDone
            ? const Color(0xFFE1F5EE)
            : const Color(0xFFEEEDFE),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: thumbnailUrl != null && !isLocked
          ? Image.asset(
              thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallbackIcon(isLocked, isDone),
            )
          : _fallbackIcon(isLocked, isDone),
    );
  }

  Widget _fallbackIcon(bool isLocked, bool isDone) {
    if (isLocked) {
      return const Icon(
        Icons.lock_outline_rounded,
        color: Colors.grey,
        size: 24,
      );
    }
    if (isDone) {
      return const Icon(
        Icons.check_circle_rounded,
        color: Color(0xFF1D9E75),
        size: 28,
      );
    }
    return Center(
      child: Text(
        'L$level',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Color(0xFF534AB7),
        ),
      ),
    );
  }
}

// ─── Status badge ─────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final LessonStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, text) = switch (status) {
      LessonStatus.unlocked => (
        'Mới',
        const Color(0xFFEEEDFE),
        const Color(0xFF3C3489),
      ),
      LessonStatus.inProgress => (
        'Dở',
        const Color(0xFFFAEEDA),
        const Color(0xFF633806),
      ),
      LessonStatus.completed => (
        '✓ Xong',
        const Color(0xFFE1F5EE),
        const Color(0xFF085041),
      ),
      LessonStatus.mastered => (
        '⭐ Master',
        const Color(0xFFFAEEDA),
        const Color(0xFF854F0B),
      ),
      LessonStatus.locked => ('Khoá', Colors.grey.shade100, Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}

// ─── Meta chip ────────────────────────────────────────────────────────────

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    this.color = const Color(0xFF9C9A92),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Star row ─────────────────────────────────────────────────────────────

class _StarRow extends StatelessWidget {
  final int stars;
  const _StarRow({required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Icon(
          i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
          color: i < stars ? const Color(0xFFEF9F27) : Colors.grey.shade300,
          size: 14,
        );
      }),
    );
  }
}
