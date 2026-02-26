class CardModel {
  final String id;
  final String emoji;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    required this.emoji,
    this.isFlipped = false,
    this.isMatched = false,
  });
}