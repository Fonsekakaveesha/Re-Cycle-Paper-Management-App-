import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_database/firebase_database.dart';

// Define your primary color here or import from your theme/colors file
const Color primaryColor = Color(0xFF2196F3); // Example: blue color
const Color backgroundColor = Color(0xFFF5F5F5); // Example: light background

// ignore: use_key_in_widget_constructors
class MachineValueScreen extends StatefulWidget {
  @override
  State<MachineValueScreen> createState() => _MachineValueScreenState();
}

class _MachineValueScreenState extends State<MachineValueScreen> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child(
    'machineValues',
  );

  int temperature = 30;
  int speed = 10;
  int thickness = 10;

  bool loading = false;

  late final Stream<DatabaseEvent> realTimeStream;

  @override
  void initState() {
    super.initState();
    // Fetch initial data and listen for real-time updates
    realTimeStream = dbRef.onValue;
    realTimeStream.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          temperature = data['temperature'] ?? 30;
          speed = data['speed'] ?? 10;
          thickness = data['thickness'] ?? 10;
        });
      }
    });
  }

  void updateValue(String key, int value) async {
    setState(() {
      loading = true;
    });
    await dbRef.update({key: value});
    setState(() {
      loading = false;
    });
  }

  Widget buildDropdown({
    required String label,
    required int currentValue,
    required List<int> items,
    required Function(int) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Georgia',
            color: Colors.black87,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<int>(
            dropdownColor: primaryColor,
            value: currentValue,
            iconEnabledColor: Colors.white,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      label == 'Temperature' ? '$e c' : e.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            underline: SizedBox(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Machine Set Value',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(5, 5),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDropdown(
                  label: 'Temperature',
                  currentValue: temperature,
                  items: List.generate(101, (i) => i), // 0 to 100 c
                  onChanged: (val) => updateValue('temperature', val),
                ),
                SizedBox(height: 20),
                buildDropdown(
                  label: 'Speed',
                  currentValue: speed,
                  items: List.generate(101, (i) => i), // 0 to 100
                  onChanged: (val) => updateValue('speed', val),
                ),
                SizedBox(height: 20),
                buildDropdown(
                  label: 'Thikens',
                  currentValue: thickness,
                  items: List.generate(101, (i) => i), // 0 to 100
                  onChanged: (val) => updateValue('thickness', val),
                ),
                SizedBox(height: 30),
                loading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // Nothing special on button press since updates on dropdown change
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Machine values updated')),
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text(
                            'Add to',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
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
