import 'package:flutter/material.dart';

import 'package:flutter_application_1/client/widgets/CustomTextField.dart';
import 'package:flutter_application_1/client/widgets/error_message.dart';
import '../screens/ForgotPasswordScreen.dart';

import '../widgets/button_custom.dart';
import '../screens/register_screen.dart'; // Import RegisterScreen
// Import NavBar

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool hiddenPassword;
  final bool loading;
  final String? errorMessage;
  final VoidCallback onLoginPressed;
  final VoidCallback onPasswordVisibilityToggled;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.hiddenPassword,
    required this.loading,
    this.errorMessage,
    required this.onLoginPressed,
    required this.onPasswordVisibilityToggled,
  });

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    // if (value.length < 6) {
    //   return 'Mật khẩu phải có ít nhất 6 ký tự';
    // }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên đăng nhập';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo2.png',
              cacheHeight: 180,
              cacheWidth: 200,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: usernameController,
              icon: Icons.account_circle_outlined,
              labelText: 'Email/Số điện thoại',
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: CustomTextField(
                controller: passwordController,
                icon: Icons.password,
                labelText: 'Mật khẩu',
                suffixIcon: IconButton(
                  icon: Icon(
                      hiddenPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: onPasswordVisibilityToggled,
                ),
                obscureText: hiddenPassword,
                validator: _validatePassword,
              ),
            ),
            if (errorMessage != null) ErrorMessage(errorMessage: errorMessage!),
            const SizedBox(height: 16.0),
            ContainerButton(
              label: 'Đăng nhập',
              onPressed: loading ? null : onLoginPressed,
            ),
            const SizedBox(height: 10.0),
            ContainerButton(
              label: 'Đăng ký',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
            ),
            const SizedBox(height: 90.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'quên mật khẩu?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
