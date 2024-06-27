import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';
import '../screens/notification_list.dart';
import '../screens/profile.dart';
import '../screens/trang_chu.dart';

class NavBar extends StatefulWidget {
  final String? token;

  const NavBar({Key? key, this.token}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    if (widget.token != null) {
      setState(() {
        _token = widget.token;
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _token = prefs.getString('authToken');
      });
    }
  }

  List<Widget> get _widgetOptions => [
        const HomePage(),
        const NotificationScreen(),
        _token != null ? ProfileScreen(token: _token!) : const LoginScreen(),
      ];

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
