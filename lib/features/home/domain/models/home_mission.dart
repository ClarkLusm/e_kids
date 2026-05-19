import 'package:flutter/material.dart';

class HomeMission {
  const HomeMission({
    required this.id,
    required this.templateId,
    required this.type,
    required this.title,
    required this.cta,
    required this.icon,
    required this.color,
    required this.status,
    required this.params,
    required this.progressValue,
    required this.targetValue,
    required this.xpReward,
    required this.durationEstMin,
  });

  final String id;
  final String templateId;
  final String type;
  final String title;
  final String cta;
  final String icon;
  final Color color;
  final String status;
  final Map<String, Object?> params;
  final int progressValue;
  final int targetValue;
  final int xpReward;
  final int durationEstMin;

  bool get isCompleted => status == 'completed';
  bool get needsWarmUp {
    return type == 'vocabulary' ||
        type == 'flashcard' ||
        type == 'review' ||
        type == 'fill_blank';
  }

  String get topicLabel {
    final topic = params['topic'];
    if (topic == null || '$topic'.trim().isEmpty) return 'bất kỳ';
    return '$topic';
  }
}
