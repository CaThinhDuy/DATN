import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/client/screens/edit_profile_screen.dart';
import 'package:flutter_application_1/client/screens/orders_screen.dart';
import 'package:flutter_application_1/client/screens/login_screen.dart'; // Thêm import màn hình đăng nhập
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({Key? key, required this.token}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _profileData;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      String data = await rootBundle.loadString('assets/profile.json');
      setState(() {
        _profileData = jsonDecode(data);
      });
    } catch (e) {
      print('Error loading profile data: $e');
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFf5f5f5),
      body: _profileData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            _profileData!['Profile'][0]['imageUrl'],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _profileData!['Profile'][0]['fullname'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _profileData!['Profile'][0]['phone'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _profileData!['Profile'][0]['email'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _profileData!['Profile'][0]['address'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.edit,
                            color: Color(0xFFee4d2d),
                          ),
                          title: const Text(
                            'Chỉnh sửa',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            _navigateToEditProfile(context);
                          },
                          selectedColor: Colors.white,
                          selectedTileColor: const Color(0xFFee4d2d),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFFee4d2d),
                          ),
                          title: const Text(
                            'Đơn hàng',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            _navigateToOrders(context);
                          },
                          selectedColor: Colors.white,
                          selectedTileColor: const Color(0xFFee4d2d),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Color(0xFFee4d2d),
                          ),
                          title: const Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            _performLogout(context);
                          },
                          selectedColor: Colors.white,
                          selectedTileColor: const Color(0xFFee4d2d),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }

  void _navigateToOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrdersScreen()),
    );
  }

  void _performLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đăng xuất'),
              onPressed: () {
                _logout().then((_) {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
