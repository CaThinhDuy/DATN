import 'dart:convert';

import 'package:flutter/services.dart';

class Profile {
  final String fullname;
  final String imageUrl;
  final String phone;
  final String email;
  final String address;

  Profile({
    required this.fullname,
    required this.imageUrl,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        fullname: json['fullname'] ?? 'Unknown',
        imageUrl: json['imageUrl'] ?? '',
        phone: json['phone'] ?? 'Unknown',
        email: json['email'] ?? '',
        address: json['address'] ?? 'NO address ');
  }
}

Future<Profile> fetchProfile() async {
  final String response = await rootBundle.loadString('assets/profile.json');
  final Map<String, dynamic> jsonData = json.decode(response);
  final List<dynamic> profileData = jsonData['Profile'];
  return Profile.fromJson(profileData[0]);
}
