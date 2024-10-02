import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const AlMathuratApp());
}

class AlMathuratApp extends StatelessWidget {
  const AlMathuratApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Mathurat App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1F4037),
            Color(0xFF99F2C8),
            Color.fromARGB(255, 13, 234, 175),
            Color.fromARGB(255, 11, 18, 15),
          ],
        ),
      ),
      child: child,
    );
  }
}