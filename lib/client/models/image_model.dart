
import 'dart:convert';
import 'package:flutter/services.dart';

class ImageModel {
  final String url;
  final String title;

  ImageModel({required this.url, required this.title});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
      title: json['title'],
    );
  }
}

Future<List<ImageModel>> fetchImages() async {
  final String response = await rootBundle.loadString('assets/images.json');
  final Map<String, dynamic> jsonData = json.decode(response);
  final List<dynamic> data = jsonData['Image'];
  return data.map((json) => ImageModel.fromJson(json)).toList();
}
