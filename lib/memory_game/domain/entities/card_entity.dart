import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardEntity {
  final String id;
  final String emoji;
  final bool isFlipped;
  final bool isMatched;
  final Color cardColor;
  GlobalKey<FlipCardState> flipKey;

  CardEntity({
    required this.id,
    required this.emoji,
    this.isFlipped = false,
    this.isMatched = false,
    this.cardColor = Colors.white,
  }) : flipKey = GlobalKey<FlipCardState>();

  CardEntity copyWith({
    String? id,
    String? emoji,
    bool? isFlipped,
    bool? isMatched,
    Color? cardColor,
  }) {
    return CardEntity(
      id: id ?? this.id,
      emoji: emoji ?? this.emoji,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
      cardColor: cardColor ?? this.cardColor,
    )..flipKey = flipKey;
  }
}