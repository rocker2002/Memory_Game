import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:memory_game/memory_game/presentation/provider/sound_service.dart';

class StartScreen extends StatefulWidget {
  final VoidCallback onStart;

  const StartScreen({Key? key, required this.onStart}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingSound = false;
  bool _musicOn = true;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SoundService.init();
      if (_musicOn) {
        SoundService.playBackgroundMusic();
      }
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    Timer(const Duration(milliseconds: 300), () async {
      await _controller.forward();  
      await _controller.reverse();  
    });
  }

  Future<void> _playButtonSound() async {
    if (_isPlayingSound) return;
    
    _isPlayingSound = true;
    try {
      await _audioPlayer.play(AssetSource('sounds/button-click.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    } finally {
      _isPlayingSound = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                final angle = _flipAnimation.value * 3.1416;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: angle <= 1.57 || angle >= 4.712
                      ? Text(
                          "Emoji Match 😎",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(3.1416),
                          child: Text(
                            "Emoji Match 😎",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () async {
                await _playButtonSound();
                widget.onStart();
              },
              child: const Text(
                'Start Game',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50,),
            IconButton(
              icon: Icon(
                _musicOn ? Icons.music_note : Icons.music_off,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _musicOn = !_musicOn;
                  if (_musicOn) {
                    SoundService.playBackgroundMusic();
                  } else {
                    SoundService.stopBackgroundMusic();
                  }
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}