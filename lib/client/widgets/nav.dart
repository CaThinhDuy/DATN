import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/client/screens/Notification.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../server/user_state.dart';
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
      backgroundColor: UI.backgroundApp,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UI.backgroundApp,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: UI.wordTile,
              size: UI.wordTileSize,
            ),
            label: 'Trang chủ',
            activeIcon: Icon(Icons.home, color: Colors.white, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,
                color: UI.wordTile, size: UI.wordTileSize),
            label: 'Thông báo',
            activeIcon:
                Icon(Icons.notifications, color: Colors.white, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: UI.wordTile, size: UI.wordTileSize),
            label: 'Cá nhân',
            activeIcon: Icon(Icons.person, color: Colors.white, size: 30),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedIconTheme: const IconThemeData(
          color: UI.wordTile,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
