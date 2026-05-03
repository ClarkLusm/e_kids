import 'package:equatable/equatable.dart';
import 'listen_tap_choice.dart';

/// Model cho quiz listen_tap — nghe âm thanh, chọn đúng hình ảnh.
///
/// JSON mẫu:
/// ```json
/// {
///   "audio_url": "cdn/audio/apple.mp3",
///   "replay_limit": 2,
///   "choices": [
///     { "word": "apple",  "image_url": "cdn/img/apple.webp",  "is_correct": true  },
///     { "word": "orange", "image_url": "cdn/img/orange.webp", "is_correct": false },
///     { "word": "grape",  "image_url": "cdn/img/grape.webp",  "is_correct": false },
///     { "word": "mango",  "image_url": "cdn/img/mango.webp",  "is_correct": false }
///   ],
///   "show_word_after_answer": true
/// }
/// ```
class ListenTapContent extends Equatable {
  /// URL audio cần nghe (mp3)
  final String audioUrl;

  /// Số lần được nghe lại (0 = không giới hạn)
  final int replayLimit;

  /// Danh sách 4 lựa chọn ảnh
  final List<ListenTapChoice> choices;

  /// Có hiện chữ dưới ảnh sau khi trả lời không
  final bool showWordAfterAnswer;

  const ListenTapContent({
    required this.audioUrl,
    this.replayLimit = 3,
    required this.choices,
    this.showWordAfterAnswer = true,
  }) : assert(choices.length == 4, 'Phải có đúng 4 lựa chọn');

  factory ListenTapContent.fromJson(Map<String, dynamic> json) {
    final choices = (json['choices'] as List)
        .map((c) => ListenTapChoice.fromJson(c as Map<String, dynamic>))
        .toList();

    final content = ListenTapContent(
      audioUrl: json['audio_url'] as String,
      replayLimit: json['replay_limit'] as int? ?? 3,
      choices: choices,
      showWordAfterAnswer: json['show_word_after_answer'] as bool? ?? true,
    );
    content._validate();
    return content;
  }

  void _validate() {
    final correctCount = choices.where((c) => c.isCorrect).length;
    assert(
      correctCount == 1,
      'Phải có đúng 1 choice với is_correct: true, hiện có $correctCount',
    );
  }

  static ListenTapContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'listen_tap');
    return ListenTapContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  /// Lựa chọn đúng
  ListenTapChoice get correctChoice => choices.firstWhere((c) => c.isCorrect);

  Map<String, dynamic> toJson() => {
    'audio_url': audioUrl,
    'replay_limit': replayLimit,
    'choices': choices.map((c) => c.toJson()).toList(),
    'show_word_after_answer': showWordAfterAnswer,
  };

  @override
  List<Object?> get props => [
    audioUrl,
    replayLimit,
    choices,
    showWordAfterAnswer,
  ];
}
