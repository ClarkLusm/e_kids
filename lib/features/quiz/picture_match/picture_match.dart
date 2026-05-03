// Domain models
export 'domain/models/picture_match_choice.dart';
export 'domain/models/picture_match_content.dart';
export 'domain/models/picture_match_state.dart';

// Use cases
export 'domain/usecases/picture_match_usecases.dart';

// Data
export 'data/picture_match_repository.dart';

// Presentation
export 'presentation/providers/picture_match_controller.dart';
export 'presentation/screens/picture_match_screen.dart';
export 'presentation/widgets/answer_feedback_widget.dart';
export 'presentation/widgets/choice_grid_widget.dart';
export 'presentation/widgets/picture_card_widget.dart';

/**
 * domain/models/ — 3 file:

  picture_match_choice.dart — model 1 lựa chọn (word + audioUrl)
  picture_match_content.dart — root model parse content_json, validate correct_word phải nằm trong choices, validate đúng 4 lựa chọn
  picture_match_state.dart — runtime state với PictureMatchStatus enum (idle → correct/wrong → revealed) và method resultOf(word) trả về ChoiceResult cho từng thẻ

  domain/usecases/ — 1 file gộp cả Fetch lẫn Save: interface IPictureMatchRepository, FetchPictureMatchUseCase, DTO PictureMatchResult, SavePictureMatchResultUseCase
  data/ — MockPictureMatchRepository với 6 câu hỏi mẫu trải đều 3 chủ đề Animals / Food / Colors
  presentation/providers/ — PictureMatchController (FamilyAsyncNotifier) xử lý: chọn đáp án → tính XP (+5 bonus nếu trả lời dưới 5 giây) → lưu DB → revealAnswer() khi sai → retry() shuffle lại choices
  presentation/widgets/ — 3 widget:

  PictureCardWidget — ảnh 220px với overlay gradient, nút phát âm có animation pulse khi tap, dịch tiếng Việt fade in sau khi trả lời
  ChoiceGridWidget — grid 2×2, mỗi thẻ animate shake khi chọn sai, đổi màu xanh/đỏ với icon ✓/✗, hiện nút phát âm sau khi answered
  AnswerFeedbackWidget — banner slide-up sau khi chọn, "+XP" khi đúng hoặc "Đáp án đúng là..." khi sai
 */
