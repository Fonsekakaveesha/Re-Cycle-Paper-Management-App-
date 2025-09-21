// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_cycle/screen/AdminMachineSetupPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paper Recycle Machine',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _machineDocRef = FirebaseFirestore.instance
      .collection('machineState')
      .doc('status');

  bool? _isMachineOn;

  @override
  void initState() {
    super.initState();
    _machineDocRef.snapshots().listen((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        bool newStatus = data['isOn'] ?? false;
        if (_isMachineOn != newStatus) {
          setState(() {
            _isMachineOn = newStatus;
          });
        }
      } else {
        _machineDocRef.set({'isOn': false});
      }
    });
  }

  Future<void> _updateMachineStatus(bool status) async {
    await _machineDocRef.set({'isOn': status});
  }

  Future<void> _toggleMachineStatus() async {
    if (_isMachineOn == null) return;
    await _updateMachineStatus(!_isMachineOn!);
  }

  @override
  Widget build(BuildContext context) {
    if (_isMachineOn == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Home'), centerTitle: true),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminMachineSetupPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Hi !.......',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: _toggleMachineStatus,
            child: Container(
              width: 250,
              height: 250,
              color: Colors.teal.shade700,
              alignment: Alignment.center,
              child: Lottie.network(
                'https://lottie.host/c7901381-df9e-492d-a803-67e52c554c40/olmA8DBUZQ.json',
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _updateMachineStatus(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isMachineOn == true
                      ? Colors.green
                      : Colors.green.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('On', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () => _updateMachineStatus(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isMachineOn == false
                      ? Colors.red
                      : Colors.red.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Off', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
