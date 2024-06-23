import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            // Image.asset(
            //   'assets/logo.png',
            //   height: 32,
            // ),
            SizedBox(width: 8),
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFee4d2d),
      ),
      backgroundColor: const Color(0xFFf5f5f5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate to edit profile page
                      _navigateToEditProfile(context);
                    },
                    selectedColor: Colors.white,
                    selectedTileColor: const Color(0xFFee4d2d),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Color(0xFFee4d2d),
                    ),
                    title: const Text(
                      'Orders',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Navigate to orders page
                      _navigateToOrders(context);
                    },
                    selectedColor: Colors.white,
                    selectedTileColor: const Color(0xFFee4d2d),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color(0xFFee4d2d),
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      // Implement logout functionality
                      _performLogout(context);
                    },
                    selectedColor: Colors.white,
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
    // Implement navigation to edit profile page
  }

  void _navigateToOrders(BuildContext context) {
    // Implement navigation to orders page
  }

  void _performLogout(BuildContext context) {
    // Implement logout functionality
  }
}
