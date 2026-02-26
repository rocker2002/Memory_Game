import 'package:memory_game/memory_game/data/datasources/emoji_datasource.dart';
import 'package:memory_game/memory_game/domain/entities/card_entity.dart';
import 'package:memory_game/memory_game/domain/repositories/emoji_repository.dart'; 

class EmojiRepositoryImpl implements EmojiRepository {
  final EmojiRemoteDataSource remoteDataSource;

  EmojiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CardEntity>> getEmojiCards(int count, String categoryName) async {
    final emojis = await remoteDataSource.fetchEmojis(count ~/ 2, categoryName);
    final cards = <CardEntity>[];

    for (var i = 0; i < emojis.length; i++) {
      final emoji = emojis[i];
      cards.add(CardEntity(
        id: '${i}_1',
        emoji: emoji,
        isFlipped: false,
        isMatched: false,
      ));
      cards.add(CardEntity(
        id: '${i}_2',
        emoji: emoji,
        isFlipped: false,
        isMatched: false,
      ));
    }

    return cards..shuffle();
  }
}
