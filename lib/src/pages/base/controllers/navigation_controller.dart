import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const home = 0;
  static const cart = 1;
  static const orders = 2;
  static const profile = 3;
}

class NavigationController extends GetxController {
  late RxInt _currentIndex;
  late PageController _pageController;

  int get currentIndex => _currentIndex.value;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;
    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}
