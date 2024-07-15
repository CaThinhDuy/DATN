import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/screens/resetPasswordScreen.dart';
// import 'package:flutter_application_1/client/screens/resetPasswordScreen.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
// import 'package:flutter_application_1/server/UserService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

import '../../server/user_services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;
  // ignore: unused_field
  String? _errorMessage;

  Future<void> _forgetPassWord(BuildContext context) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final String email = _emailController.text;

    final success = await UserService.forgetPassWord(email);

    setState(() {
      _loading = false;
    });

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
      );
      SnackBar(content: const Text('Gửi mail lấy lại mật khẩu thành công'));
    } else {
      setState(() {
        _errorMessage = 'Gửi mail không thành công. Vui lòng thử lại.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UI.backgroundApp,
        title: const Text(
          'Quên mật khẩu',
          style: TextStyle(
              color: UI.wordTile,
              fontSize: UI.wordTileSize,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logo2.png',
              cacheHeight: 180,
              cacheWidth: 200,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : ContainerButton(
                    onPressed: () {
                      _forgetPassWord(context);
                    },
                    label: 'Gửi yêu cầu đặt lại mật khẩu',
                  ),
          ],
        ),
      ),
    );
  }
}
