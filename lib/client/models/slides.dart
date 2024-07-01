import 'dart:convert';
import 'package:flutter/services.dart';

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
