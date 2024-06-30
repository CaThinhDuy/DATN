import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/user_db.dart';
import '../../server/UserService.dart';
import '../widgets/button_custom.dart';
// Import màn hình hồ sơ

class EditProfileScreen extends StatefulWidget {
  final String token;
  final int id;
  const EditProfileScreen({super.key, required this.token, required this.id});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<User?> futureProfile;
  late TextEditingController lastNameController;
  late TextEditingController firstNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  Future<User?> fetchProfile() async {
    return UserService.getUserProfile(widget.token, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chỉnh sửa cá nhân',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
      ),
      body: FutureBuilder<User?>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Không tải được hồ sơ'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            firstNameController = TextEditingController(text: user.firstName);
            lastNameController = TextEditingController(text: user.lastName);
            phoneController = TextEditingController(text: user.phone);
            emailController = TextEditingController(text: user.email);
            addressController = TextEditingController(text: user.address1);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: ClipRect(
                      child: Image.network(
                        user.avatar ?? user.avatar!,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'Họ'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Tên'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Số điện thoại'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Địa chỉ'),
                  ),
                  const SizedBox(height: 20),
                  ContainerButton(
                    label: 'Lưu',
                    onPressed: () async {
                      Map<String, dynamic> updatedData = {
                        'avatar': user.avatar,
                        'first_name': firstNameController.text,
                        'last_name': lastNameController.text,
                        'phone': phoneController.text,
                        'email': emailController.text,
                        'address1': addressController.text,
                      };

                      User? updatedUser = await UserService.updateUserProfile(
                          widget.token, widget.id, updatedData);

                      if (updatedUser != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cập nhật hồ sơ thành công')),
                        );
                        Navigator.pop(context,
                            updatedUser); // Trả về màn hình trước đó với user đã cập nhật
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cập nhật hồ sơ thất bại')),
                        );
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu hồ sơ'));
          }
        },
      ),
    );
  }
}
