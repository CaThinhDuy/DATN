import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/screens/Notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/notification_list.dart';
import '../screens/profile.dart';
import '../screens/login_screen.dart';
import '../screens/trang_chu.dart';

class NavBar extends StatefulWidget {
  final String? token;
  final int? id;
  const NavBar({super.key, this.token, this.id});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String? _token;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = widget.token ?? prefs.getString('token');
      _userId = widget.id ?? prefs.getInt('id');
    });
  }

  List<Widget> get _widgetOptions => [
        const HomePage(),
        if (_token != null && _userId != null)
          NotificationScreen(
            UserID: _userId!,
            token: _token!,
          )
        else
          const NotificationNoToken(),
        if (_token != null && _userId != null)
          ProfileScreen(
            token: _token!,
            onLogout: _updateToken,
            idUser: _userId!,
          )
        else
          const LoginScreen(),
      ];

  void _updateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('id');
    setState(() {
      _token = null;
      _userId = null;
      _selectedIndex = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
