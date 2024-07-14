// lib/widgets/register_form.dart
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/server/UserService.dart';

import '../../server/user_services.dart';
import 'custom_text_field.dart';
import 'error_message.dart';
import 'button_custom.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hiddenPassword = true;
  bool _loading = false;
  String? _errorMessage;

  Future<void> _register(BuildContext context) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;

    final success = await UserService.register(username, password, email);

    setState(() {
      _loading = false;
    });

    if (success) {
      Navigator.pop(context); // Go back to login screen
    } else {
      setState(() {
        _errorMessage = 'Đăng ký không thành công. Vui lòng thử lại.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: _usernameController,
          icon: Icons.account_circle_outlined,
          labelText: 'Tên đăng nhập',
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          controller: _emailController,
          icon: Icons.email,
          labelText: 'Email',
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: CustomTextField(
            controller: _passwordController,
            icon: Icons.password,
            labelText: 'Mật khẩu',
            obscureText: _hiddenPassword,
            suffixIcon: IconButton(
              icon: Icon(
                  _hiddenPassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _hiddenPassword = !_hiddenPassword;
                });
              },
            ),
          ),
        ),
        if (_errorMessage != null) ErrorMessage(errorMessage: _errorMessage!),
        const SizedBox(height: 16.0),
        ContainerButton(
          label: 'Đăng ký',
          onPressed: _loading ? null : () => _register(context),
        ),
      ],
    );
  }
}
