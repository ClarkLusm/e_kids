import 'card_content.dart';

enum CardFaceState {
  faceDown, // đang úp, chờ được lật
  faceUp, // đã lật, chờ khớp cặp
  matched, // đã ghép đúng, mờ dần
  mismatch, // lật sai, đang hiện trước khi úp lại
}

class CardState {
  final String pairId;
  final CardContent content;

  /// true = cardA, false = cardB — phân biệt 2 thẻ cùng cặp
  final bool isCardA;

  CardFaceState faceState;

  CardState({
    required this.pairId,
    required this.content,
    required this.isCardA,
    this.faceState = CardFaceState.faceDown,
  });

  /// Thẻ có thể được tap không
  bool get isInteractable => faceState == CardFaceState.faceDown;

  /// Thẻ đã ghép xong chưa
  bool get isMatched => faceState == CardFaceState.matched;

  /// Thẻ đang hiển thị mặt trước không
  bool get isFaceUp =>
      faceState == CardFaceState.faceUp ||
      faceState == CardFaceState.mismatch ||
      faceState == CardFaceState.matched;
}
