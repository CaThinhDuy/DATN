import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/UserService.dart';
import 'CustomTextField.dart';
import 'error_message.dart';
import 'button_custom.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hiddenPassword = true;
  bool _loading = false;
  String? _errorMessage;

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await UserService.register(
        context,
        _usernameController,
        _passwordController,
        _emailController,
        (loading) {
          setState(() {
            _loading = loading;
          });
        },
        (errorMessage) {
          setState(() {
            _errorMessage = errorMessage;
          });
        },
      );
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên đăng nhập';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Vui lòng nhập email hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
            controller: _usernameController,
            icon: Icons.account_circle_outlined,
            labelText: 'Tên đăng nhập',
            validator: _validateUsername,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: _emailController,
            icon: Icons.email,
            labelText: 'Email',
            validator: _validateEmail,
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
              validator: _validatePassword,
            ),
          ),
          if (_errorMessage != null) ErrorMessage(errorMessage: _errorMessage!),
          const SizedBox(height: 16.0),
          ContainerButton(
            label: 'Đăng ký',
            onPressed: _loading ? null : () => _register(context),
          ),
        ],
      ),
    );
  }
}
