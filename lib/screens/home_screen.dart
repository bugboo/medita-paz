import 'package:flutter/material.dart';
import 'meditation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Começar meditação"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MeditationScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}