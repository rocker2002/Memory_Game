import '../repositories/emoji_repository.dart';
import '../entities/card_entity.dart';

class GetEmojiCards {
  final EmojiRepository repository;

  GetEmojiCards(this.repository);

  Future<List<CardEntity>> call(int count, String categoryName) async {
    return await repository.getEmojiCards(count, categoryName);
  }
}