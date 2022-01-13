import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/api_client.dart';
import 'package:tesis/logic/auth/login_bloc.dart';
import 'package:tesis/logic/auth/login_event.dart';
import 'package:tesis/logic/auth/login_state.dart';
import 'package:tesis/screens/cursos_screen.dart';
import 'package:tesis/logic/models/models.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    Future<List<Curso>> cursos = apiClient.getCursos();
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: _loginForm(cursos),
        ));
  }

  Widget _loginForm(Future<List<Curso>> cursos) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usuario(),
            _contrasena(),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<Curso>>(
                future: cursos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _loginButton(context, snapshot.data!);
                  } else {
                    return Center(
                        child: CircularProgressIndicator(value: null));
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _usuario() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
              icon: Icon(Icons.person), hintText: 'Username'),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginUsernameChanged(username: value)),
        );
      },
    );
  }

  Widget _contrasena() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.security), hintText: 'Password'),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _loginButton(BuildContext context, List<Curso> cursos) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          if (apiClient.login(state.username, state.password)) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CursosScreen(cursos: cursos)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login fallido')));
          }
        },
        child: const Text('Ingresar'),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF1C958E),
          fixedSize: const Size(250, 30),
        ),
      );
    });
  }
}
