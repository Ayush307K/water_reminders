import 'package:flutter/material.dart';
import 'package:water_reminders/widgets/custom_button.dart';
import 'package:water_reminders/services/firebase_auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Intake Reminder'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuthService().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Water Intake Reminder App!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Set Reminder',
                onPressed: () {
                  Navigator.pushNamed(context, '/reminder_settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
