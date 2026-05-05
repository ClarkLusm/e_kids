/// Interface cho speech recognition service — inject qua Riverpod.
abstract class ISpeechRecognitionService {
  /// Trả về true nếu thiết bị hỗ trợ STT
  Future<bool> initialize();

  /// Bắt đầu lắng nghe, trả về transcript khi xong
  Future<String?> listen({required Duration timeout, String? localeId});

  /// Dừng ghi âm
  Future<void> stop();

  bool get isListening;
}

/// Tính điểm similarity giữa 2 string (0.0–1.0).
/// Dùng Levenshtein distance normalized.
class SimilarityCalculator {
  /// So sánh transcript với danh sách variants được chấp nhận.
  /// Trả về điểm cao nhất trong tất cả variants.
  static double calculate(String transcript, List<String> acceptedVariants) {
    if (transcript.isEmpty) return 0.0;

    final cleaned = _clean(transcript);
    double best = 0.0;

    for (final variant in acceptedVariants) {
      final score = _levenshteinSimilarity(cleaned, _clean(variant));
      if (score > best) best = score;
    }
    return best;
  }

  static String _clean(String s) =>
      s.toLowerCase().trim().replaceAll(RegExp(r'[^a-z\s]'), '');

  static double _levenshteinSimilarity(String a, String b) {
    if (a == b) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;

    final maxLen = a.length > b.length ? a.length : b.length;
    final dist = _levenshteinDistance(a, b);
    return 1.0 - dist / maxLen;
  }

  static int _levenshteinDistance(String s1, String s2) {
    final m = s1.length;
    final n = s2.length;
    final dp = List.generate(m + 1, (i) => List.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) dp[i][0] = i;
    for (var j = 0; j <= n; j++) dp[0][j] = j;

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] =
              1 +
              [
                dp[i - 1][j],
                dp[i][j - 1],
                dp[i - 1][j - 1],
              ].reduce((a, b) => a < b ? a : b);
        }
      }
    }
    return dp[m][n];
  }
}
