import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:re_cycle/screen/start_screen.dart';

class SplashScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds then navigate to the home page
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the MyHomePage from main.dart
      // ignore: use_build_context_synchronously
      Navigator.of(
        // ignore: use_build_context_synchronously
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const StartScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Lottie.network(
            'https://lottie.host/c7901381-df9e-492d-a803-67e52c554c40/olmA8DBUZQ.json',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
