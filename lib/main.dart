import 'package:flutter/material.dart';
import 'package:go_rent/views/pages/auth/login.dart';
import 'package:go_rent/views/pages/auth/register.dart';
import 'package:go_rent/views/pages/home/main_page.dart';
import 'package:go_rent/views/pages/splash_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        backgroundColor: lightColor,
      ),
      home: const SplashScreenPage(),
      routes: {
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        'home': (context) => const MainPage(),
      },
    );
  }
}
