import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tesis/screens/cursos_screen.dart';
import './screens/login_screen.dart';
import 'screens/rubrica_screen.dart';
import 'screens/rubrica_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      home: LoginScreen(),
    );
  }
}
