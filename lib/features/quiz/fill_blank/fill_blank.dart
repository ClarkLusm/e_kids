// Domain models
export 'domain/models/fill_blank_content.dart';
export 'domain/models/fill_blank_state.dart';

// Use cases
export 'domain/usecases/fill_blank_usecases.dart';

// Data
export 'data/fill_blank_repository.dart';

// Presentation
export 'presentation/providers/fill_blank_controller.dart';
export 'presentation/screens/fill_blank_screen.dart';
export 'presentation/widgets/fill_blank_feedback_widget.dart';
export 'presentation/widgets/fill_blank_illustration_widget.dart';
export 'presentation/widgets/sentence_display_widget.dart';
export 'presentation/widgets/word_chip_bar_widget.dart';

/**
 * domain/models/fill_blank_content.dart — Model parse content_json với helper tiện lợi: sentenceParts tách câu tại ___, beforeBlank / afterBlank cho widget render, completeSentence lắp đáp án đúng vào. Validation đảm bảo câu phải có ___ và correct_answer phải nằm trong choices.
  domain/models/fill_blank_state.dart — Runtime state với FillBlankStatus (idle → selected → correct/wrong → revealed) và 2 enum phụ: FillBlankSlotStatus cho ô trống, ChipStatus cho từng word chip. Method statusOf(word) trả về đúng trạng thái chip để widget tự render màu mà không cần logic if/else.
  domain/usecases/ — Interface IFillBlankRepository, DTO FillBlankResult (có hintsUsed để tính XP), FetchFillBlankUseCase, SaveFillBlankResultUseCase.
  data/fill_blank_repository.dart — 11 câu mock trải đều 4 chủ đề: Animals (4 câu), Food (3 câu), Colors (2 câu), Actions (2 câu). Đủ để test toàn bộ flow.
  presentation/providers/fill_blank_controller.dart — FillBlankController xử lý: selectWord() (tap lại từ đang chọn → bỏ chọn), submitAnswer() (tính XP: base 10 + no-hint bonus 5 + speed bonus 5), toggleHint() (đếm lần dùng hint trừ vào XP), revealAnswer() (phát audio câu đúng sau reveal), retry().
  presentation/widgets/ — 4 widget:

  SentenceDisplayWidget — card trắng hiển thị câu, phần _BlankSlot có bounce animation khi từ được điền vào, dịch tiếng Việt AnimatedSize slide xuống khi hint
  WordChipBarWidget + _WordChip — chips với press-scale animation (92% khi nhấn), đổi màu theo ChipStatus, hiện ✓/✗ icon sau khi answered
  FillBlankIllustrationWidget — ảnh compact 130px để dành không gian cho câu văn
  FillBlankFeedbackWidget — nút "Kiểm tra" disabled khi chưa chọn, slide-up banner feedback với nút phụ "Xem đáp án đúng"
 */
