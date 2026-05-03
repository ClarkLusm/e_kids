import 'package:equatable/equatable.dart';

/// Model cho quiz letter_scramble — kéo/tap chữ cái ghép thành từ đúng.
///
/// JSON mẫu:
/// ```json
/// {
///   "word": "elephant",
///   "image_url": "cdn/img/elephant.webp",
///   "audio_url": "cdn/audio/elephant.mp3",
///   "scrambled_letters": ["E","L","P","H","A","N","T","E"],
///   "locked_positions": [0],
///   "max_hints": 2,
///   "translation_vi": "con voi",
///   "phonetic": "ˈel.ɪ.fənt"
/// }
/// ```
class LetterScrambleContent extends Equatable {
  /// Từ cần ghép (lowercase so sánh case-insensitive)
  final String word;

  /// Ảnh minh hoạ
  final String? imageUrl;

  /// Audio phát âm từ
  final String? audioUrl;

  /// Danh sách chữ cái đã xáo trộn — lưu sẵn để đồng nhất across thiết bị
  final List<String> scrambledLetters;

  /// Danh sách index bị khóa cố định (hint chữ đầu = [0])
  final List<int> lockedPositions;

  /// Số gợi ý tối đa được dùng
  final int maxHints;

  /// Nghĩa tiếng Việt
  final String? translationVi;

  /// Phiên âm IPA
  final String? phonetic;

  const LetterScrambleContent({
    required this.word,
    this.imageUrl,
    this.audioUrl,
    required this.scrambledLetters,
    this.lockedPositions = const [],
    this.maxHints = 1,
    this.translationVi,
    this.phonetic,
  });

  factory LetterScrambleContent.fromJson(Map<String, dynamic> json) {
    final scrambled = List<String>.from(
      (json['scrambled_letters'] as List).map((e) => e.toString()),
    );
    final locked = List<int>.from(
      (json['locked_positions'] as List? ?? []).map((e) => e as int),
    );

    final content = LetterScrambleContent(
      word: (json['word'] as String).toLowerCase(),
      imageUrl: json['image_url'] as String?,
      audioUrl: json['audio_url'] as String?,
      scrambledLetters: scrambled,
      lockedPositions: locked,
      maxHints: json['max_hints'] as int? ?? 1,
      translationVi: json['translation_vi'] as String?,
      phonetic: json['phonetic'] as String?,
    );
    content._validate();
    return content;
  }

  void _validate() {
    assert(
      scrambledLetters.length == word.length,
      'scrambledLetters.length (${scrambledLetters.length}) '
      'phải bằng word.length (${word.length})',
    );
    // Kiểm tra scrambledLetters chứa đúng các ký tự của word
    final wordChars = word.toUpperCase().split('')..sort();
    final scrambledChars = List<String>.from(
      scrambledLetters.map((l) => l.toUpperCase()),
    )..sort();
    assert(
      wordChars.toString() == scrambledChars.toString(),
      'scrambledLetters phải chứa đúng các ký tự của word "$word"',
    );
  }

  static LetterScrambleContent fromQuestion(Map<String, dynamic> question) {
    assert(question['quiz_type'] == 'letter_scramble');
    return LetterScrambleContent.fromJson(
      question['content_json'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
    'word': word,
    if (imageUrl != null) 'image_url': imageUrl,
    if (audioUrl != null) 'audio_url': audioUrl,
    'scrambled_letters': scrambledLetters,
    'locked_positions': lockedPositions,
    'max_hints': maxHints,
    if (translationVi != null) 'translation_vi': translationVi,
    if (phonetic != null) 'phonetic': phonetic,
  };

  /// Chữ cái tại index có bị khóa không
  bool isLocked(int index) => lockedPositions.contains(index);

  @override
  List<Object?> get props => [
    word,
    imageUrl,
    audioUrl,
    scrambledLetters,
    lockedPositions,
    maxHints,
    translationVi,
    phonetic,
  ];
}
