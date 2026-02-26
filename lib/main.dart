import 'package:flutter/material.dart';
import 'package:memory_game/memory_game/data/datasources/emoji_datasource.dart';
import 'package:memory_game/memory_game/data/repositories/emoji_repository_impl.dart';
import 'package:memory_game/memory_game/domain/usecases/get_emoji_cards.dart';
import 'package:memory_game/memory_game/presentation/provider/game_provider.dart';
import 'package:memory_game/memory_game/presentation/screens/game_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EmojiRemoteDataSource>(
          create: (context) => EmojiRemoteDataSourceImpl(client: http.Client()),
        ),
        Provider<EmojiRepositoryImpl>(
          create: (context) => EmojiRepositoryImpl(
            remoteDataSource: context.read<EmojiRemoteDataSource>(),
          ),
        ),
        Provider<GetEmojiCards>(
          create: (context) => GetEmojiCards(context.read<EmojiRepositoryImpl>()),
        ),
        ChangeNotifierProvider<GameProvider>(
          create: (context) => GameProvider(
            getEmojiCards: context.read<GetEmojiCards>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memory Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const GameScreen(gridSize: 4), 
      ),
    );
  }
}