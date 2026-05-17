import 'package:e_kids/features/home/domain/models/skill_progress_summary.dart';
import 'package:e_kids/features/home/presentation/providers/skill_progress_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillGoalSettingsScreen extends ConsumerWidget {
  const SkillGoalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(parentSkillGoalProgressProvider);
    final actionState = ref.watch(skillGoalActionProvider);

    ref.listen(skillGoalActionProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Mục tiêu học của bé')),
      body: SafeArea(
        child: skillsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Lỗi: $error')),
          data: (skills) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Thiết lập mục tiêu level hiện tại',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              const Text(
                '100% nghĩa là bé hoàn thành đủ số đơn vị yêu cầu cho từng kỹ năng. XP chỉ là phần thưởng, không dùng làm chuẩn năng lực.',
                style: TextStyle(color: Colors.black54, height: 1.4),
              ),
              const SizedBox(height: 20),
              for (final skill in skills) ...[
                _SkillGoalCard(
                  skill: skill,
                  isBusy: actionState.isLoading,
                  onChange: (nextTarget) => _updateTarget(
                    ref,
                    skill: skill,
                    requiredUnits: nextTarget,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateTarget(
    WidgetRef ref, {
    required SkillProgressSummary skill,
    required int requiredUnits,
  }) {
    return ref
        .read(skillGoalActionProvider.notifier)
        .updateTarget(skill: skill, requiredUnits: requiredUnits);
  }
}

class _SkillGoalCard extends StatelessWidget {
  const _SkillGoalCard({
    required this.skill,
    required this.isBusy,
    required this.onChange,
  });

  final SkillProgressSummary skill;
  final bool isBusy;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    final unitLabel = _unitLabel(skill.unitType);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: skill.color.withValues(alpha: 0.35),
          width: 2,
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(skill.icon, style: const TextStyle(fontSize: 30)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  skill.label,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '${skill.progressPercent.round()}%',
                style: TextStyle(
                  color: skill.color,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: skill.progress,
              color: skill.color,
              backgroundColor: skill.color.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Đã hoàn thành ${skill.completedUnits}/${skill.requiredUnits} $unitLabel',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _GoalButton(
                label: '-5',
                enabled: !isBusy && skill.requiredUnits > 5,
                onTap: () => onChange(skill.requiredUnits - 5),
              ),
              const SizedBox(width: 8),
              _GoalButton(
                label: '-1',
                enabled: !isBusy && skill.requiredUnits > 1,
                onTap: () => onChange(skill.requiredUnits - 1),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${skill.requiredUnits} $unitLabel',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              _GoalButton(
                label: '+1',
                enabled: !isBusy,
                onTap: () => onChange(skill.requiredUnits + 1),
              ),
              const SizedBox(width: 8),
              _GoalButton(
                label: '+5',
                enabled: !isBusy,
                onTap: () => onChange(skill.requiredUnits + 5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _unitLabel(String unitType) {
    return switch (unitType) {
      'words' => 'từ',
      'questions' => 'câu',
      'utterances' => 'lượt nói',
      _ => 'đơn vị',
    };
  }
}

class _GoalButton extends StatelessWidget {
  const _GoalButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onTap : null,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 40),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}
