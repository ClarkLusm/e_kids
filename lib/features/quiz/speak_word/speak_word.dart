// Domain models
export 'domain/models/speak_word_content.dart';
export 'domain/models/speak_word_state.dart';
export 'domain/models/speech_recognition_service.dart';

// Use cases
export 'domain/usecases/speak_word_usecases.dart';

// Data
export 'data/speak_word_repository.dart';

// Presentation
export 'presentation/providers/speak_word_controller.dart';
export 'presentation/screens/speak_word_screen.dart';
export 'presentation/widgets/mic_button_widget.dart';
export 'presentation/widgets/speak_word_card_widget.dart';
export 'presentation/widgets/speak_word_feedback_widget.dart';

/**
 * speak_word_content.dart — parse content_json với các field đặc thù: acceptedVariants (danh sách biến thể phát âm được chấp nhận, bao gồm lỗi phổ biến của trẻ Việt), minSimilarityScore (ngưỡng 0.0–1.0), syllableBreakdown hiện gợi ý sau khi sai. Helper displayWord (title case) và syllableDisplay ("but · ter · fly").
  speak_word_state.dart — runtime state với SpeakWordStatus 7 trạng thái: idle → listening → processing → correct/wrong → maxReached/revealed. List attempts ghi lại từng lần thử với transcript + similarity + passed. Computed bestSimilarity, attemptsRemaining, canTryAgain.
  speech_recognition_service.dart — interface ISpeechRecognitionService tách biệt STT khỏi business logic, và SimilarityCalculator thuần Dart dùng Levenshtein distance normalized để so sánh transcript với acceptedVariants — không phụ thuộc package nào.
  domain/usecases/ — DTO SpeakWordResult ghi bestTranscript, bestSimilarity, attemptCount để phân tích sau. Interface repository + 2 use case.
  data/ — 11 câu mock chia 3 nhóm độ khó: Dễ (3–4 âm: cat/dog/fish/bird), Trung bình (5–6 âm: apple/rabbit/mango/yellow), Khó (7+ âm: elephant/butterfly/crocodile). MockSpeechRecognitionService giả lập 2 giây delay, thực tế thay bằng speech_to_text package.
  presentation/providers/speak_word_controller.dart — Luồng xử lý: startListening() → gọi STT → _processTranscript() chạy SimilarityCalculator → nếu passed → _handleCorrect(), nếu hết lượt → _handleMaxReached(), còn lượt → status = wrong + bật showSyllableHint sau khi sai ≥ 2 lần. XP: base 20 + first-try bonus 10 + second-try bonus 5 + high-similarity bonus 5.
  presentation/widgets/ — 3 widget:
  MicButtonWidget — nút tròn 88px với 3 vòng sóng đỏ khi listening, pulse tím khi idle/wrong, spinner khi processing, đổi icon mic ↔ stop. _AttemptDots hiện số chấm đỏ theo số lần đã thử.
  SpeakWordCardWidget — card hiển thị từ lớn 32px, phonetic IPA, _SyllableHint màu amber ("but · ter · fly"), dịch tiếng Việt expandable, _SimilarityMeter thanh tiến độ màu xanh/vàng/đỏ theo ngưỡng với threshold marker.
  SpeakWordFeedbackWidget — toolbar 2 nút (Gợi ý/Xem đáp án) khi đang chơi, banner slide-up khi answered với stat chips ("Lần đầu đúng 🎯", "Phát âm chuẩn 🔊", "Phản xạ nhanh ⚡").
 */
