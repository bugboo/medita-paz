import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MeditaEmPazApp());
}

class MeditaEmPazApp extends StatelessWidget {
  const MeditaEmPazApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7CCBFF),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medita em Paz',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,

        scaffoldBackgroundColor: const Color(0xFFEAF6FF),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB8E3FF),
          foregroundColor: Color(0xFF2C5D7A),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7CCBFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}