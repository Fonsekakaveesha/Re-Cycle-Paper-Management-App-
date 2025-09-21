// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:re_cycle/screen/machinesetup_screen.dart';

class AdminMachineSetupPage extends StatefulWidget {
  const AdminMachineSetupPage({super.key});

  @override
  State<AdminMachineSetupPage> createState() => _AdminMachineSetupPageState();
}

class _AdminMachineSetupPageState extends State<AdminMachineSetupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  void _signIn() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(const SnackBar(content: Text('Signed in successfully')));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? 'Authentication failed';
    } catch (e) {
      errorMessage = 'Something went wrong';
    }

    setState(() {
      isLoading = false;
    });

    if (errorMessage.isNotEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  void _forgotPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email to reset password'),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send reset email')),
      );
    }
  }

  // Add a valid Lottie animation URL
  final String lottieUrl =
      'https://lottie.host/c7901381-df9e-492d-a803-67e52c554c40/olmA8DBUZQ.json';

  @override
  Widget build(BuildContext context) {
    const Color buttonColor = Color(0xFF16796F);

    return Scaffold(
      backgroundColor: const Color(0xFF99B9B7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              children: [
                // Icon with shadow behind (like photo)
                Stack(
                  children: [
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Icon(
                        Icons.recycling,
                        size: 100,
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ),
                    const Icon(Icons.recycling, size: 100, color: buttonColor),
                  ],
                ),

                // Title "PaperRecycle" styled
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: buttonColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'P',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(text: 'aper'),
                      TextSpan(
                        text: 'Re',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'cycle'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card background with rounded corners like photo
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF99B9B7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Addmin\nMachine Setup',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email field
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Password field
                      const Text(
                        'Password',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Forget Password text button right aligned
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _forgotPassword,
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Set Up button with proper color and white text
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: isLoading ? null : _signIn,
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Set UP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MachineValueScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Machine Setup',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Lottie animation below card (optional)
                SizedBox(
                  height: 150,
                  child: Lottie.network(lottieUrl, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
