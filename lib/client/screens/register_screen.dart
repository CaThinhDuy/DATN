import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng  ký',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo2.png',
                cacheHeight: 180,
                cacheWidth: 180,
              ),
              const SizedBox(height: 16.0),
              RegisterForm(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Bạn đã có tài khoản? '),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blueAccent)),
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  bool hidden = true;
  bool hidden2 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.account_circle_outlined),
            labelText: 'Email/Số điện thoại',
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: const Icon(Icons.password),
                labelText: 'Mật khẩu',
                suffixIcon: IconButton(
                  icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                ),
              ),
              obscureText: hidden,
            )),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                controller: _passwordController2,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  labelText: 'Nhập lại mật khẩu',
                  suffixIcon: IconButton(
                    icon:
                        Icon(hidden2 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hidden2 = !hidden2;
                      });
                    },
                  ),
                ),
                obscureText: hidden2,
              )),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.08,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: const ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 92, 52))),
              onPressed: null,
              child: Text(
                'ĐĂNG KÝ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          alignment: AlignmentDirectional.bottomCenter,
          height: MediaQuery.sizeOf(context).height * 0.08,
          width: MediaQuery.sizeOf(context).width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  cacheHeight: 50,
                ),
                const Text(
                  'Đăng ký với Google',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
