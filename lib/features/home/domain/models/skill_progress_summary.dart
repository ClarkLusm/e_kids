import 'package:flutter/material.dart';

class SkillProgressSummary {
  const SkillProgressSummary({
    required this.childId,
    required this.pathId,
    required this.level,
    required this.skillKey,
    required this.label,
    required this.icon,
    required this.color,
    required this.completedUnits,
    required this.requiredUnits,
    required this.unitType,
    required this.progressPercent,
  });

  final String childId;
  final String pathId;
  final int level;
  final String skillKey;
  final String label;
  final String icon;
  final Color color;
  final int completedUnits;
  final int requiredUnits;
  final String unitType;
  final double progressPercent;

  double get progress => (progressPercent / 100).clamp(0.0, 1.0);
}
