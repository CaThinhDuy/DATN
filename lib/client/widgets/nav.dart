import 'package:flutter/material.dart';

import '../screens/notification_list.dart';
import '../screens/profile.dart';
import '../screens/trang_chu.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const NotificationScreen(),
    const ProfileScreen(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Trang chủ',
            activeIcon: Icon(Icons.home, color: Colors.white, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.white),
            label: 'Thông báo',
            activeIcon:
                Icon(Icons.notifications, color: Colors.white, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Cá nhân',
            activeIcon: Icon(Icons.person, color: Colors.white, size: 30),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 255, 92, 52),
        onTap: _onItemTapped,
      ),
    );
  }
}
