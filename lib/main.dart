import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water_reminders/screens/auth_check.dart';
import 'package:water_reminders/screens/create_account_page.dart';
import 'package:water_reminders/screens/home_screen.dart';
import 'package:water_reminders/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Intake Reminder',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheckPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => CreateAccountPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
