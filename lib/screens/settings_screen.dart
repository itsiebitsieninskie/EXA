import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9147FF),
      appBar: AppBar(
        title: const Text('Settings'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 129, 45, 255),
      ),
      body: const Center(
        child: Text(
          'Settings Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
