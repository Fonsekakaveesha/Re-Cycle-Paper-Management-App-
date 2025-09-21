import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:re_cycle/screen/Welcome_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  final Color buttonColor = const Color(0xFF16796F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie Animation
              SizedBox(
                height: 500,
                child: Lottie.network(
                  'https://lottie.host/5d710772-972c-4cbe-9912-6926e29b5cf6/qYuzsZ3Klv.json',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 35),

              // Text: "Reduce , Reuse , Recycle"
              const Text(
                'Reduce , Reuse , Recycle',
                style: TextStyle(fontSize: 22, color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Text: "Repeat !"
              Text(
                'Repeat !',
                style: TextStyle(
                  fontSize: 26,
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
