// Domain models
export 'domain/models/listen_tap_choice.dart';
export 'domain/models/listen_tap_content.dart';
export 'domain/models/listen_tap_state.dart';

// Use cases
export 'domain/usecases/listen_tap_usecases.dart';

// Data
export 'data/listen_tap_repository.dart';

// Presentation
export 'presentation/providers/listen_tap_controller.dart';
export 'presentation/screens/listen_tap_screen.dart';
export 'presentation/widgets/audio_player_widget.dart';
export 'presentation/widgets/image_choice_grid_widget.dart';
export 'presentation/widgets/listen_tap_feedback_widget.dart';

/**
 * listen_tap_choice.dart — model đơn giản: word, imageUrl, isCorrect.
  listen_tap_content.dart — parse content_json, validate đúng 1 choice có is_correct: true, helper correctChoice trả về choice đúng, replayLimit = 0 nghĩa là không giới hạn.
  listen_tap_state.dart — runtime state với ListenTapStatus enum 6 trạng thái: waitingToPlay (chưa nghe lần nào, nút play nổi bật) → playing (đang phát) → idle (đã nghe, chờ chọn) → correct/wrong/revealed. Method cardStatusOf(word) trả ChoiceCardStatus cho grid tự render. canReplay và replaysRemaining kiểm soát số lần nghe lại.
  domain/usecases/ — DTO ListenTapResult có replayCount để phân tích sau, interface IAudioPlayerService tách biệt service phát âm khỏi business logic.
  data/ — 9 câu mock trải đều Animals (cat/elephant/monkey), Food (apple/pizza/banana), Colors (red/purple), Numbers (three). MockAudioPlayerService giả lập delay 800ms.
  presentation/providers/listen_tap_controller.dart — Logic quan trọng: auto-play audio khi vừa load xong, bắt đầu đếm giờ từ lần nghe đầu tiên (không phải từ khi load), chặn chọn đáp án nếu chưa nghe lần nào (waitingToPlay). XP tính thưởng ít replay: nghe 1 lần +5, nghe 2 lần +2, nghe ≥3 lần không thưởng.
  presentation/widgets/ — 3 widget đặc trưng:
  AudioPlayerWidget — nút tròn 80px với 3 vòng sóng âm AnimationController riêng biệt (delay 0ms / 240ms / 480ms để tạo hiệu ứng lan toả), pulse animation khi waitingToPlay, đổi icon play ↔ volume_up khi đang phát, status text animated switch.
  ImageChoiceGridWidget + _ImageChoiceCard — grid 2×2, ảnh fullscreen trong card, border màu xanh/đỏ 3px khi answered, overlay màu mờ, badge ✓/✗ góc phải trên với elasticOut scale animation, label word fade in phía dưới ảnh sau khi trả lời.
  ListenTapFeedbackWidget — slide-up banner, icon 🎧 thay vì 🎉 (đặc trưng quiz nghe), hiện "Nghe 1 lần! 👂" nếu trả lời đúng chỉ qua 1 lần replay.
 */
