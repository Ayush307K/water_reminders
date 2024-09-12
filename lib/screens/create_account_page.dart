import 'package:flutter/material.dart';
import 'package:water_reminders/widgets/custom_button.dart';
import 'package:water_reminders/widgets/custom_text_field.dart';
import 'package:water_reminders/services/firebase_auth_service.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _createAccount() async {
    setState(() {
      _isLoading = true;
    });
    bool success = await FirebaseAuthService().createAccount(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account creation failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                text: 'Create Account',
                onPressed: _createAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
