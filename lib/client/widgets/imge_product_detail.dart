import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product_image.dart';

class ImageSlider extends StatefulWidget {
  final ProductImage proImg;

  const ImageSlider({super.key, required this.proImg});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: PageView(
        controller: _pageController,
        children: [
          Image.network(
            widget.proImg.image1,
            fit: BoxFit.cover,
          ),
          Image.network(
            widget.proImg.image2,
            fit: BoxFit.cover,
          ),
          Image.network(
            widget.proImg.image3,
            fit: BoxFit.cover,
          ),
          // Image.network(
          //   widget.proImg.image4,
          //   fit: BoxFit.cover,
          // ),
          // Image.network(
          //   widget.proImg.image5,
          //   fit: BoxFit.cover,
          // ),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}