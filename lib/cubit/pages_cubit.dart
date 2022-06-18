import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragable_card/cubit/pages_state.dart';
import 'package:dragable_card/models/page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/card_model.dart';

class PagesCubit extends Cubit<PagesState> {
  PagesCubit() : super(InitPagesState());

  Timer? _debounceVScroll;
  Timer? _debounceHScroll;

  final double _scrollVOffset = 150;
  int _currentPageIndex = 0;
  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;

  void setScrollController(PageModel page, ScrollController controller) {
    if (page == pages[_currentPageIndex]) {
      _scrollController = controller;
    }
  }

  void scrollUp() {
    bool cantScrollTop = scrollController?.offset == 0 &&
        scrollController?.position.atEdge == true;
    if (cantScrollTop) return;
    scrollVerticallyToOffset(_scrollVOffset * -1);
  }

  void scrollVerticallyToOffset(double offset) {
    _debounceVScroll = Timer(const Duration(milliseconds: 300), () {
      if (scrollController == null) return;
      double scrollToOffset = (scrollController?.offset ?? 0) + offset;

      scrollController?.animateTo(
        scrollToOffset,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  void scrollDown() {
    bool cantScrollDown = scrollController?.offset != 0 &&
        scrollController?.position.atEdge == true;

    if (cantScrollDown) return;
    scrollVerticallyToOffset(_scrollVOffset);
  }

  final List<PageModel> _pages = [
    PageModel(
      title: "page 1",
      cardsColor: Colors.grey.shade200,
      cardList: [
        CardModel(name: "1-1", id: "1"),
        CardModel(name: "1-2", id: "2"),
        CardModel(name: "1-3", id: "3"),
        CardModel(name: "1-4", id: "4"),
        CardModel(name: "1-5", id: "5"),
        CardModel(name: "1-6", id: "6"),
        CardModel(name: "1-7", id: "7"),
        CardModel(name: "1-8", id: "8"),
        CardModel(name: "1-9", id: "4"),
      ],
    ),
    PageModel(
      title: "page 2",
      cardsColor: Colors.yellow.shade100,
      cardList: [
        CardModel(name: "2-1", id: "11"),
        CardModel(name: "2-2", id: "12"),
        CardModel(name: "2-3", id: "13"),
        CardModel(name: "2-4", id: "14"),
        CardModel(name: "2-5", id: "15"),
        CardModel(name: "2-6", id: "16"),
      ],
    ),
    PageModel(
      title: "page 3",
      cardsColor: Colors.green.shade100,
      cardList: [
        CardModel(name: "3-1", id: "21"),
        CardModel(name: "3-2", id: "22"),
        CardModel(name: "3-3", id: "23"),
        CardModel(name: "3-4", id: "24"),
      ],
    ),
    PageModel(
      title: "page 4",
      cardsColor: Colors.blueGrey.shade300,
      cardList: [
        CardModel(name: "4-1", id: "31"),
        CardModel(name: "4-2", id: "32"),
        CardModel(name: "4-3", id: "33"),
        CardModel(name: "4-4", id: "34"),
        CardModel(name: "4-5", id: "35"),
      ],
    ),
    PageModel(
      title: "page 5",
      cardsColor: Colors.brown.shade200,
      cardList: [
        CardModel(name: "5-1", id: "41"),
        CardModel(name: "5-2", id: "42"),
        CardModel(name: "5-3", id: "43"),
      ],
    ),
  ];

  List<PageModel> get pages => _pages;

  CarouselController? _carouselController;
  CarouselController? get carouselController => _carouselController;
  set setCarouselController(CarouselController controller) {
    _carouselController = controller;
  }

  void nextPage() {
    _debounceHScroll = Timer(const Duration(milliseconds: 300), () {
      _carouselController?.nextPage();
      _currentPageIndex = (_currentPageIndex++) % pages.length;
    });
  }

  void previousPage() {
    _debounceHScroll = Timer(const Duration(milliseconds: 300), () {
      _carouselController?.previousPage();
      _currentPageIndex--;

      if (_currentPageIndex < 0) {
        _currentPageIndex = pages.length;
      }
    });
  }
}
