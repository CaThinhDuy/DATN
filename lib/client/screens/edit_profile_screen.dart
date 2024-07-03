import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';

import '../models/profile.dart';

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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load profile'));
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
                  SizedBox(height: 20),
                  TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(labelText: 'Họ tên'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Số điện thoại'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Địa chỉ'),
                  ),
                  SizedBox(height: 20),
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
            return Center(child: Text('No profile data available'));
          }
        },
      ),
    );
  }
}
