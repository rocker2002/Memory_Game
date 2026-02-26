import 'package:flutter/material.dart';
import 'package:memory_game/memory_game/domain/entities/card_entity.dart';
import 'package:memory_game/memory_game/domain/usecases/get_emoji_cards.dart';

class GameProvider with ChangeNotifier {
  final GetEmojiCards getEmojiCards;

  GameProvider({required this.getEmojiCards});

  List<CardEntity> _cards = [];
  List<CardEntity> get cards => _cards;

  CardEntity? _firstCard;
  CardEntity? _secondCard;

  int _attempts = 0;
  int get attempts => _attempts;

  int _score = 0;
  int get score => _score;

  bool _isGameStarted = false;
  bool get isGameStarted => _isGameStarted;

  bool _canFlip = true;
  bool get canFlip => _canFlip;

  Color? _cardColor;
  Color? get cardColor => _cardColor;

  String _selectedLevel = 'Easy';
  String get selectedLevel => _selectedLevel;

  String _selectedCategory = 'food-and-drink';
  String get selectedCategory => _selectedCategory;

  bool _screenShown = false;
  bool get screenShown => _screenShown;

  void setSelectedLevel(String value){
    _selectedLevel = value;
    notifyListeners();
  }

  void setSelectedCategory(String value){
    _selectedCategory = value;
    notifyListeners();
  }

  Future<void> startGame() async {
    _score = 0;
    _attempts = 0;
    _firstCard = null;
    _secondCard = null;
    _isGameStarted = true;
    _canFlip = false;
    _screenShown = false;
    notifyListeners();

    if(selectedLevel == 'Easy'){
      _cards = await getEmojiCards.call(8, selectedCategory);
    }else if(selectedLevel == 'Medium'){
      _cards = await getEmojiCards.call(12, selectedCategory); 
    }else{
      _cards = await getEmojiCards.call(20, selectedCategory); 
    }

    
    _cards = _cards.map((card) => card.copyWith(
      isFlipped: false,
      isMatched: false,
    )).toList();

    notifyListeners();


    for (var card in _cards) {
      await Future.delayed(const Duration(milliseconds: 50));
      card.flipKey.currentState?.toggleCard();
    }

    await Future.delayed(const Duration(seconds: 2));

    for (var card in _cards) {
      await Future.delayed(const Duration(milliseconds: 50));
      card.flipKey.currentState?.toggleCard();
    }

    _canFlip = true;
    notifyListeners();
  }

  void flipCard(CardEntity card) {
  if (!_canFlip || card.isMatched || card.isFlipped) return;

  final index = _cards.indexWhere((c) => c.id == card.id);
  if (index == -1) return;

  _cards[index] = card.copyWith(isFlipped: true);
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _cards[index].flipKey.currentState?.toggleCard();
  });

  notifyListeners();

  if (_firstCard == null) {
    _firstCard = _cards[index];
  } else {
    _secondCard = _cards[index];
    _checkForMatch();
  }
}
  void _checkForMatch() async{
    _canFlip = false;
    _attempts++;
    notifyListeners();

    if (_firstCard?.emoji == _secondCard?.emoji) {
      _score += 100;
      
      final firstIndex = _cards.indexWhere((c) => c.id == _firstCard?.id);
      
      final secondIndex = _cards.indexWhere((c) => c.id == _secondCard?.id);
      
      await Future.delayed(const Duration(milliseconds: 200));
      _cards[firstIndex] = _cards[firstIndex].copyWith(isMatched: true, cardColor: Colors.green);
      await Future.delayed(const Duration(milliseconds: 200));
      _cards[secondIndex] = _cards[secondIndex].copyWith(isMatched: true, cardColor: Colors.green);
      

      
      _firstCard = null;
      _secondCard = null;
      _canFlip = true;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        final firstIndex = _cards.indexWhere((c) => c.id == _firstCard?.id);
        final secondIndex = _cards.indexWhere((c) => c.id == _secondCard?.id);
        
        _cards[firstIndex].flipKey.currentState?.toggleCard();
        _cards[secondIndex].flipKey.currentState?.toggleCard();
        
        _cards[firstIndex] = _cards[firstIndex].copyWith(isFlipped: false);
        _cards[secondIndex] = _cards[secondIndex].copyWith(isFlipped: false);
        
        _firstCard = null;
        _secondCard = null;
        _canFlip = true;
        notifyListeners();
      });
    }
  }
  
 Future<bool> isGameComplete() async{
    await Future.delayed(const Duration(milliseconds: 500));
    _screenShown = true;
    return _cards.isNotEmpty && _cards.every((card) => card.isMatched);
  }

  void cardColorState(CardEntity card){
      if (card.isMatched) {
        Future.delayed(Duration(milliseconds: 800), () {
          _cardColor = Colors.green;
      });
    }else{
      _cardColor = Colors.white;
    }
  }

  void resetGame() {
    _cards = [];
    _firstCard = null;
    _secondCard = null;
    _attempts = 0;
    _score = 0;
    _isGameStarted = false;
    _canFlip = false;
    _screenShown = false;
    notifyListeners();
  }
}