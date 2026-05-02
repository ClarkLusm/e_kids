enum CardType {
  image,
  word,
  audio,
  mixed,
}

class CardContent {
  final CardType type;
  final String? imageUrl;
  final String? word;
  final String? audioUrl;
  final String? translationVi;
  final String? backColor;

  const CardContent({
    required this.type,
    this.imageUrl,
    this.word,
    this.audioUrl,
    this.translationVi,
    this.backColor,
  });

  void validate() {
    switch (type) {
      case CardType.image:
        assert(imageUrl != null);
      case CardType.word:
        assert(word != null && word!.isNotEmpty);
      case CardType.audio:
        assert(audioUrl != null);
      case CardType.mixed:
        assert(word != null && imageUrl != null);
    }
  }
}
