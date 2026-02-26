import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundService {
  static final AudioPlayer _effectPlayer = AudioPlayer();
  static final AudioPlayer _musicPlayer = AudioPlayer();
  static bool _isInitialized = false;
  static bool _musicPlaying = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      await _effectPlayer.setReleaseMode(ReleaseMode.release);
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      _isInitialized = true;
    }
  }

  static Future<void> playFlipSound() async {
    try {
      await _effectPlayer.play(AssetSource('sounds/card_flip.mp3'));
    } catch (e) {
      debugPrint('Flip sound error: $e');
    }
  }

  static Future<void> playBackgroundMusic() async {
    if (_musicPlaying) return;
    
    try {
      await _musicPlayer.play(AssetSource('sounds/background_music.mp3'));
      _musicPlaying = true;
    } catch (e) {
      debugPrint('Background music error: $e');
    }
  }

  static Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer.stop();
      _musicPlaying = false;
    } catch (e) {
      debugPrint('Stop music error: $e');
    }
  }

  static Future<void> setMusicVolume(double volume) async {
    try {
      await _musicPlayer.setVolume(volume);
    } catch (e) {
      debugPrint('Volume set error: $e');
    }
  }

  static void dispose() {
    _effectPlayer.dispose();
    _musicPlayer.dispose();
  }
}