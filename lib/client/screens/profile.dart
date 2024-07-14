import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/user_db.dart';
import 'package:flutter_application_1/client/widgets/nav.dart';
// import '../../server/UserService.dart';
import '../../server/user_services.dart';
import '../../server/user_state.dart';
import 'edit_profile_screen.dart';
// import 'login_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  final Function() onLogout;
  final int idUser;

  const ProfileScreen({
    super.key,
    required this.token,
    required this.onLogout,
    required this.idUser,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user =
          await UserService.getUserProfile(widget.token, widget.idUser);
      if (user != null) {
        setState(() {
          _userData = user;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không tìm thấy thông tin người dùng'),
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã xảy ra lỗi khi tải dữ liệu người dùng'),
        ),
      );
      print('Lỗi lấy dữ liệu: $e');
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFf5f5f5),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
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
                            _userData!.avatar ??
                                ('https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'),
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
                            _navigateToEditProfile();
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

  void _navigateToEditProfile() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          token: widget.token,
          id: widget.idUser,
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        _userData = updatedUser;
      });
    }
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
                    MaterialPageRoute(builder: (context) => const NavBar()),
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
    // Thực hiện các thao tác đăng xuất ở đây, ví dụ như xóa token, dữ liệu đăng nhập, v.v.
    widget.onLogout(); // Gọi callback onLogout để thông báo cho widget cha
  }
}
