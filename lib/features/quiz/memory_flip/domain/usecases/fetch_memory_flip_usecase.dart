import '../models/memory_flip_content.dart';

/// Interface repository — Data layer implement
abstract class IMemoryFlipRepository {
  Future<MemoryFlipContent> fetchById(String questionId);
}

/// Use case: lấy content_json và parse thành MemoryFlipContent
class FetchMemoryFlipUseCase {
  final IMemoryFlipRepository _repository;

  const FetchMemoryFlipUseCase(this._repository);

  Future<MemoryFlipContent> call(String questionId) =>
      _repository.fetchById(questionId);
}
