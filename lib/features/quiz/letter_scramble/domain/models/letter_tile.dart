/// Đại diện cho một ô chữ cái trong game.
/// Mỗi tile có ID duy nhất để track trong DragTarget.
class LetterTile {
  /// ID unique — dùng làm key trong widget tree
  final String id;

  /// Chữ cái (uppercase để hiển thị)
  final String letter;

  /// Tile này có bị khóa (không drag được) không
  final bool isLocked;

  LetterTile({required this.id, required this.letter, required this.isLocked});

  LetterTile copyWith({String? id, String? letter, bool? isLocked}) =>
      LetterTile(
        id: id ?? this.id,
        letter: letter ?? this.letter,
        isLocked: isLocked ?? this.isLocked,
      );

  @override
  String toString() =>
      'LetterTile(id: $id, letter: $letter, locked: $isLocked)';
}
