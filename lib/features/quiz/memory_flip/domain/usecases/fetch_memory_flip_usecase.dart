import '../models/memory_flip_content.dart';

typedef FetchMemoryFlipContentHandler =
    Future<MemoryFlipContent> Function({
      required String lessonId,
      required String quizId,
    });

class FetchMemoryFlipUseCase {
  const FetchMemoryFlipUseCase(this._handler);

  final FetchMemoryFlipContentHandler _handler;

  Future<MemoryFlipContent> call({
    required String lessonId,
    required String quizId,
  }) {
    return _handler(lessonId: lessonId, quizId: quizId);
  }
}
