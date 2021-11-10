import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              SizedBox(
                height: 24,
              ),
              _loginButton(context),
            ],
          ),
        ));
  }

  Widget _usernameField() {
    return TextFormField(
      decoration:
          const InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          icon: Icon(Icons.security), hintText: 'Password'),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cursos');
      },
      child: const Text('Ingresar'),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF1C958E),
        fixedSize: const Size(250, 30),
      ),
    );
  }
}
