// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ImageModel {
//   final String url;
//   final String title;

//   ImageModel({required this.url, required this.title});

//   factory ImageModel.fromJson(Map<String, dynamic> json) {
//     return ImageModel(
//       url: json['url'],
//       title: json['title'],
//     );
//   }
// }

// Future<List<ImageModel>> fetchImages() async {
//   final response = await http.get(Uri.parse('https://example.com/images.json'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => ImageModel.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load images');
//   }
// }
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
