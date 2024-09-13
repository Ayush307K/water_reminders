import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:water_reminders/screens/auth_check.dart';
import 'package:water_reminders/screens/create_account_page.dart';
import 'package:water_reminders/screens/home_screen.dart';
import 'package:water_reminders/screens/login_page.dart';
import 'package:water_reminders/screens/notification_management.dart';
import 'package:water_reminders/screens/reminder_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    // Request permission for iOS
    _firebaseMessaging.requestPermission();

    // Get the token for the device
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM Token: $token");
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    return MaterialApp(
      title: 'Water Intake Reminder',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheckPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => CreateAccountPage(),
        '/home': (context) => HomeScreen(),
        '/reminder_settings': (context) => ReminderSettingsScreen(userId: '',),
        '/notifications': (context) => NotificationManagementPage(),
      },
    );
  }
}
