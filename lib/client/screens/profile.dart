import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/user_db.dart';
import '../../server/UserService.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  final Function() onLogout;
  final int idUser;

  const ProfileScreen({
    Key? key,
    required this.token,
    required this.onLogout,
    required this.idUser,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  user? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      user? User =
          await UserService.getUserProfile(widget.token, widget.idUser);
      if (User != null) {
        setState(() {
          _userData = User;
        });
      } else {
        // Handle error or show a message
      }
    } catch (e) {
      // Handle error or show a message
      print('Error loading user profile: $e');
    }
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
      body: _userData == null
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
                            _userData!.avatar!,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          ' ${_userData!.lastName}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _userData!.phone!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _userData!.email!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Color.fromARGB(255, 255, 92, 52),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _userData!.address1!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
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

  Future<void> _performLogout(BuildContext context) async {
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

  Future<void> _logout() async {
    // Perform logout operations here, e.g., clearing tokens, preferences, etc.
    widget.onLogout(); // Call the onLogout callback to notify the parent widget
  }
}
