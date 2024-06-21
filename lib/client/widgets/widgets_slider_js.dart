import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetsViewSlider extends StatefulWidget {
  const WidgetsViewSlider({Key? key}) : super(key: key);

  @override
  _WidgetsViewSliderState createState() => _WidgetsViewSliderState();
}

class _WidgetsViewSliderState extends State<WidgetsViewSlider> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  List<Slide> _slides = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadSlides();
  }

  Future<void> _loadSlides() async {
    final slides = await fetchSlides();
    setState(() {
      _slides = slides;
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < _slides.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
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
      child: _slides.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              children:
                  _slides.map((slide) => Image.asset(slide.image)).toList(),
            ),
    );
  }
}

class Slide {
  final String image;

  Slide({required this.image});

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      image: json['image'],
    );
  }
}

Future<List<Slide>> fetchSlides() async {
  final String response = await rootBundle.loadString('assets/slides.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Slide.fromJson(json)).toList();
}
