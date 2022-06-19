import 'package:flutter/material.dart';

import 'card_model.dart';

class PageModel {
  final String title;
  final Color cardsColor;
  final List<CardModel> cardList;

  PageModel({
    required this.title,
    required this.cardsColor,
    required this.cardList,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageModel &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
