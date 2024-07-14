import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/notification_list.dart';
import '../screens/profile.dart';
import '../screens/login_screen.dart';
import '../screens/trang_chu.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  final String? token;
  final int? id;
  const NavBar({Key? key, this.token, this.id}) : super(key: key);

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
      context.read<UserState>().setUserId(_userId!);
    });
  }

  List<Widget> get _widgetOptions => [
        const HomePage(),
        const NotificationScreen(),
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
      context.read<UserState>().setUserId(-1);
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
        items: const [
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
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        onTap: _onItemTapped,
      ),
    );
  }
}
