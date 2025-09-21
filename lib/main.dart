import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:re_cycle/screen/splash_screen.dart';
import 'package:re_cycle/screen/start_screen.dart';
import 'package:re_cycle/screen/Welcome_screen.dart';
import 'package:re_cycle/screen/signin_screen.dart';
import 'package:re_cycle/screen/signup_screen.dart';
import 'package:re_cycle/screen/Home_screen.dart';
import 'package:re_cycle/screen/AdminMachineSetupPage.dart';
import 'package:re_cycle/screen/machinesetup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCycle App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/adminSetup': (context) => const AdminMachineSetupPage(),
        '/machineSetup': (context) => MachineValueScreen(),
      },
    );
  }
}
