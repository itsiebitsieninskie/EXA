import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nina_homework/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeWorkApp());
}

class HomeWorkApp extends StatelessWidget {
  const HomeWorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}
