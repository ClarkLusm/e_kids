import 'package:equatable/equatable.dart';

class ScoreConfig extends Equatable {
  final int baseXp;
  final bool weightMultiplier;
  final bool timeBonus;
  final int timeBonusThresholdSec;
  final int timeBonusXp;
  final bool flipPenalty;
  final int flipPenaltyAfter;
  final int flipPenaltyXp;

  const ScoreConfig({
    this.baseXp = 10,
    this.weightMultiplier = true,
    this.timeBonus = false,
    this.timeBonusThresholdSec = 60,
    this.timeBonusXp = 20,
    this.flipPenalty = false,
    this.flipPenaltyAfter = 30,
    this.flipPenaltyXp = 2,
  });

  factory ScoreConfig.fromJson(Map<String, dynamic> json) => ScoreConfig(
    baseXp: json['base_xp'] as int? ?? 10,
    weightMultiplier: json['weight_multiplier'] as bool? ?? true,
    timeBonus: json['time_bonus'] as bool? ?? false,
    timeBonusThresholdSec: json['time_bonus_threshold_sec'] as int? ?? 60,
    timeBonusXp: json['time_bonus_xp'] as int? ?? 20,
    flipPenalty: json['flip_penalty'] as bool? ?? false,
    flipPenaltyAfter: json['flip_penalty_after'] as int? ?? 30,
    flipPenaltyXp: json['flip_penalty_xp'] as int? ?? 2,
  );

  Map<String, dynamic> toJson() => {
    'base_xp': baseXp,
    'weight_multiplier': weightMultiplier,
    'time_bonus': timeBonus,
    'time_bonus_threshold_sec': timeBonusThresholdSec,
    'time_bonus_xp': timeBonusXp,
    'flip_penalty': flipPenalty,
    'flip_penalty_after': flipPenaltyAfter,
    'flip_penalty_xp': flipPenaltyXp,
  };

  @override
  List<Object?> get props => [
    baseXp,
    weightMultiplier,
    timeBonus,
    timeBonusThresholdSec,
    timeBonusXp,
    flipPenalty,
    flipPenaltyAfter,
    flipPenaltyXp,
  ];
}

class AccessibilityConfig extends Equatable {
  final bool showLabelOnBack;
  final bool highContrastBorder;
  final bool autoReadOnFlip;

  const AccessibilityConfig({
    this.showLabelOnBack = true,
    this.highContrastBorder = false,
    this.autoReadOnFlip = true,
  });

  factory AccessibilityConfig.fromJson(Map<String, dynamic> json) =>
      AccessibilityConfig(
        showLabelOnBack: json['show_label_on_back'] as bool? ?? true,
        highContrastBorder: json['high_contrast_border'] as bool? ?? false,
        autoReadOnFlip: json['auto_read_on_flip'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
    'show_label_on_back': showLabelOnBack,
    'high_contrast_border': highContrastBorder,
    'auto_read_on_flip': autoReadOnFlip,
  };

  @override
  List<Object?> get props => [
    showLabelOnBack,
    highContrastBorder,
    autoReadOnFlip,
  ];
}
