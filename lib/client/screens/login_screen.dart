import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/UserService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hiddenPassword = true;
  bool _loading = false;
  String? _errorMessage;

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  void _setErrorMessage(String? message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: UI.backgroundApp,
      ),
      body: LoginForm(
        usernameController: _usernameController,
        passwordController: _passwordController,
        hiddenPassword: _hiddenPassword,
        loading: _loading,
        errorMessage: _errorMessage,
        onLoginPressed: () => UserService.login(
          context,
          _usernameController,
          _passwordController,
          _setLoading,
          _setErrorMessage,
        ),
        onPasswordVisibilityToggled: () {
          setState(() {
            _hiddenPassword = !_hiddenPassword;
          });
        },
      ),
    );
  }
}
