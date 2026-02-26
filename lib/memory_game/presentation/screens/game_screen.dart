import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:memory_game/memory_game/presentation/provider/game_provider.dart';
import 'package:memory_game/memory_game/presentation/provider/sound_service.dart';
import 'package:memory_game/memory_game/presentation/screens/start_screen.dart';
import 'package:memory_game/memory_game/presentation/widgets/game_over.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  final int gridSize;
  static const List<String> levels = ['Easy', 'Medium', 'Hard'];
  static const List<String> categories = [
    'food-and-drink',
    'animals-and-nature',
    'travel-and-places'
  ];

  const GameScreen({Key? key, required this.gridSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, provider, _) {
            if (!provider.isGameStarted) {
              return StartScreen(onStart: () => provider.startGame());
            }

            return FutureBuilder<bool>(
              future: provider.isGameComplete(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showWinDialog(context, provider);
                  });
                }
                if (!snapshot.data! && provider.attempts >= 15) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showLoseDialog(context, provider);
                  });
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Memory Match",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "You have 15 attempts to match all new flavours",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Attempts",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              Text("${provider.attempts}/15",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: provider.attempts / 15,
                            backgroundColor: Colors.white12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridSize,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: provider.cards.length,
                          itemBuilder: (context, index) {
                            final card = provider.cards[index];
                            return FlipCard(
                              key: card.flipKey,
                              flipOnTouch: false,
                              direction: FlipDirection.HORIZONTAL,
                              front: GestureDetector(
                                onTap: () {
                                  if (provider.canFlip &&
                                      !card.isMatched &&
                                      !card.isFlipped) {
                                    SoundService.playFlipSound();
                                    provider.flipCard(card);
                                  }
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              back: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: card.cardColor,
                                child: Center(
                                  child: Text(
                                    card.emoji,
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    _buildBottomControls(provider),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomControls(GameProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownMenu(
              initialSelection: provider.selectedLevel,
              dropdownMenuEntries: levels
                  .map((level) => DropdownMenuEntry(value: level, label: level))
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  provider.setSelectedLevel(value);
                  provider.startGame();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownMenu(
              initialSelection: provider.selectedCategory,
              dropdownMenuEntries: categories
                  .map((category) => DropdownMenuEntry(
                        value: category,
                        label: category.replaceAll('-', ' '),
                      ))
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  provider.setSelectedCategory(value);
                  provider.startGame();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}