import 'dart:async';
import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with SingleTickerProviderStateMixin {
  bool started = false;
  int seconds = 0;
  Timer? timer;

  late AnimationController breathController;

  String selectedMode = "Respiração livre";

  @override
  void initState() {
    super.initState();

    breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.9,
      upperBound: 1.1,
    );
  }

  void toggleSession() {
    if (started) {
      timer?.cancel();
      breathController.stop();

      setState(() {
        started = false;
      });
      return;
    }

    setState(() {
      started = true;
      seconds = 0;
    });

    breathController.repeat(reverse: true);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  String formatTime() {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEAF6FF),
              Color(0xFFD6EEFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Escolha sua prática",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF2C5D7A),
                  ),
                ),

                const SizedBox(height: 12),

                DropdownButton<String>(
                  value: selectedMode,
                  items: const [
                    DropdownMenuItem(
                      value: "Respiração livre",
                      child: Text("Respiração livre"),
                    ),
                    DropdownMenuItem(
                      value: "Relaxamento profundo",
                      child: Text("Relaxamento profundo"),
                    ),
                    DropdownMenuItem(
                      value: "Foco mental",
                      child: Text("Foco mental"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value!;
                    });
                  },
                ),

                const SizedBox(height: 40),

                Text(
                  formatTime(),
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3D6F95),
                  ),
                ),

                const SizedBox(height: 40),

                ScaleTransition(
                  scale: breathController,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8E3FF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.15),
                          blurRadius: 25,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  started
                      ? "Inspire... expire..."
                      : "Toque para começar",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2C5D7A),
                  ),
                ),

                const SizedBox(height: 40),

                GestureDetector(
                  onTap: toggleSession,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: started
                          ? const Color(0xFFFF7B7B)
                          : const Color(0xFF7CCBFF),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Text(
                      started ? "Finalizar" : "Iniciar",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}