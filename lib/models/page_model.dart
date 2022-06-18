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
}
