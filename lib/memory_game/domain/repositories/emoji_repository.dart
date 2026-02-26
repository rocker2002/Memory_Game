import '../entities/card_entity.dart';

abstract class EmojiRepository {
  Future<List<CardEntity>> getEmojiCards(int count, String categoryName);
}