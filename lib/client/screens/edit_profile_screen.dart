import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../widgets/button_custom.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<Profile> futureProfile;
  late TextEditingController fullnameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
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
      body: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load profile'));
          } else if (snapshot.hasData) {
            final profile = snapshot.data!;
            fullnameController = TextEditingController(text: profile.fullname);
            phoneController = TextEditingController(text: profile.phone);
            emailController = TextEditingController(text: profile.email);
            addressController = TextEditingController(text: profile.address);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: ClipRect(
                      child: Image.network(
                        profile.imageUrl,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: fullnameController,
                    decoration: const InputDecoration(labelText: 'Họ tên'),
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
                    onPressed: () {
                      //xu ly luu
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text('No profile data available'));
          }
        },
      ),
    );
  }
}
