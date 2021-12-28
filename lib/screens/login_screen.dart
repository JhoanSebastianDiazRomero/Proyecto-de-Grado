import 'package:flutter/material.dart';
import 'package:tesis/screens/cursos_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
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
          ),
        ));
  }

  Widget _usernameField() {
    return TextFormField(
      decoration:
          const InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
      validator: (value) => null,
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          icon: Icon(Icons.security), hintText: 'Password'),
      validator: (value) => null,
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CursosScreen()));
      },
      child: const Text('Ingresar'),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF1C958E),
        fixedSize: const Size(250, 30),
      ),
    );
  }
}
