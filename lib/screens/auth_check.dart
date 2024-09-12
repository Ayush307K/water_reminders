import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart'; // Firebase authentication service
import 'home_screen.dart';
import 'login_page.dart';

class AuthCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuthService().isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasData && snapshot.data == true) {
          return HomeScreen(); // User is authenticated, navigate to home
        } else {
          return LoginPage(); // User is not authenticated, go to login
        }
      },
    );
  }
}
