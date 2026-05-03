// Domain models
export 'domain/models/letter_scramble_content.dart';
export 'domain/models/letter_scramble_state.dart';
export 'domain/models/letter_tile.dart';

// Use cases
export 'domain/usecases/letter_scramble_usecases.dart';

// Data
export 'data/letter_scramble_repository.dart';

// Presentation
export 'presentation/providers/letter_scramble_controller.dart';
export 'presentation/screens/letter_scramble_screen.dart';
export 'presentation/widgets/answer_slots_widget.dart';
export 'presentation/widgets/scramble_feedback_widget.dart';
export 'presentation/widgets/source_tiles_widget.dart';
export 'presentation/widgets/word_image_card.dart';

/**
 * domain/models/ — 3 file:
  letter_tile.dart — model nhỏ đại diện 1 ô chữ, có id unique để track trong Drag system và isLocked để phân biệt tile gợi ý cố định với tile người dùng đặt.
  letter_scramble_content.dart — parse content_json, validate scrambledLetters phải chứa đúng ký tự của word (sort và so sánh), helper isLocked(index) để check vị trí khóa.
  letter_scramble_state.dart — runtime state với 2 list song song: sourceTiles (pool phía dưới) và answerSlots (ô trả lời phía trên). Method slotStateAt(i) trả SlotDisplayState enum cho widget tự render màu, firstEmptySlotIndex cho tap-to-place, isWordCorrect so sánh case-insensitive.
  domain/usecases/ — DTO LetterScrambleResult ghi cả hintsUsed, wrongAttempts lên DB để phân tích sau.
  data/ — 15 câu mock: Animals dễ (cat/dog/bird/fish — 3–4 chữ), Animals trung (rabbit/monkey/elephant/giraffe — 6–8 chữ), Food (rice/apple/mango), Colors (blue/green/yellow).
  presentation/providers/letter_scramble_controller.dart — Controller đầy đủ nhất trong series với 8 action:

  tapSourceTile() → đặt vào slot trống đầu tiên
  tapAnswerSlot() → trả tile về source
  dragTileToSlot() → drag từ source hoặc swap giữa các slot
  dragTileToSource() → drag tile từ answer về pool
  _autoSubmit() → tự check khi đủ chữ
  useHint() → tìm slot sai/trống đầu tiên, lấy đúng tile từ source đặt vào, khóa cố định
  clearAll() → trả tất cả tile chưa khóa về source
  revealAnswer() → điền đáp án đúng vào tất cả slot

  presentation/widgets/ — 4 widget:
  AnswerSlotsWidget — hàng DragTarget<String>, kích thước tile tự điều chỉnh theo độ dài từ (58px cho ≤4 chữ → 38px cho >8 chữ), pop-bounce animation khi tile được đặt vào.
  SourceTilesWidget — pool Draggable<String> với elasticOut appear animation, ghost tile khi đang kéo, _LetterTileBox với 4 style (normal/dragging/ghost/disabled).
  WordImageCard — compact card 150px với audio button pulse animation, hiện phonetic + dịch tiếng Việt sau khi trả lời.
  ScrambleFeedbackWidget — 2 chế độ: toolbar 3 nút (Gợi ý/Xoá/Đáp án) khi đang chơi, banner slide-up với stat chips (không dùng gợi ý / không sai / trả lời nhanh) khi đã trả lời.
 */
