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
  final int progressValue;
  final int targetValue;
  final int xpReward;
  final int durationEstMin;
}
