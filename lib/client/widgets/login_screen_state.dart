// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../widgets/login_form.dart';
// import '../screens/login_screen.dart';
// import '../widgets/nav.dart'; // Import NavBar

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _hiddenPassword = true;
//   bool _loading = false;
//   String? _errorMessage;

//   Future<void> _saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('authToken', token);
//   }

//   Future<void> _login(BuildContext context) async {
//     setState(() {
//       _loading = true;
//       _errorMessage = null;
//     });

//     final String username = _usernameController.text;
//     final String password = _passwordController.text;
//     String host = '192.168.43.206';
//     final response = await http.post(
//       Uri.parse('http://$host:3000/login'), // Replace with your server URL
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );

//     setState(() {
//       _loading = false;
//     });

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseBody = jsonDecode(response.body);
//       final String token = responseBody['token'];

//       // Lưu token vào SharedPreferences
//       await _saveToken(token);

//       // Navigate to NavBar upon successful login
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => NavBar(token: token)),
//       );
//     } else {
//       // Handle error
//       setState(() {
//         _errorMessage = 'Đăng nhập không thành công. Vui lòng thử lại.';
//       });
//       print('Login failed, status code: ${response.statusCode}');
//       print('Response: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Đăng nhập',
//           style: TextStyle(
//               color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromARGB(255, 255, 92, 52),
//       ),
//       body: LoginForm(
//         usernameController: _usernameController,
//         passwordController: _passwordController,
//         hiddenPassword: _hiddenPassword,
//         loading: _loading,
//         errorMessage: _errorMessage,
//         onLoginPressed: () => _login(context),
//         onPasswordVisibilityToggled: () {
//           setState(() {
//             _hiddenPassword = !_hiddenPassword;
//           });
//         },
//       ),
//     );
//   }
// }
