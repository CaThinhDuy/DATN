import 'dart:async';

import 'package:flutter/material.dart';

class PageViewSlider extends StatefulWidget {
  const PageViewSlider({Key? key}) : super(key: key);

  @override
  _PageViewSliderState createState() => _PageViewSliderState();
}

class _PageViewSliderState extends State<PageViewSlider> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: PageView(
        controller: _pageController,
        children: [
          Image.asset('assets/b1.png'),
          Image.asset('assets/b2.png'),
          Image.asset('assets/b3.png'),
        ],
      ),
    );
  }
}