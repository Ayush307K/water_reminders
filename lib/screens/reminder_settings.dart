import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/notification_toggle.dart';
import '../widgets/time_picker.dart';
import '../widgets/location_selector.dart';
import '../widgets/custom_text_field.dart';

class ReminderSettingsScreen extends StatefulWidget {
  final String userId; // Add this line to receive the user ID

  ReminderSettingsScreen({required this.userId}); // Update the constructor

  @override
  _ReminderSettingsScreenState createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool _notificationsEnabled = false;
  TimeOfDay _reminderTime = TimeOfDay.now();
  String _selectedLocation = 'None';
  String _customMessage = '';
  String _reminderFrequency = 'Daily'; // Default frequency
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load preferences from Firebase Realtime Database
  void _loadPreferences() async {
    try {
      DataSnapshot snapshot = await _database.child('users/${widget.userId}/settings').get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _notificationsEnabled = values['notificationsEnabled'] ?? false;
          _customMessage = values['customMessage'] ?? '';
          _reminderFrequency = values['reminderFrequency'] ?? 'Daily';
          _selectedLocation = values['selectedLocation'] ?? 'None';
          int hour = values['reminderHour'] ?? _reminderTime.hour;
          int minute = values['reminderMinute'] ?? _reminderTime.minute;
          _reminderTime = TimeOfDay(hour: hour, minute: minute);
        });
      }
    } catch (e) {
      print('Error loading preferences: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Save preferences to Firebase Realtime Database
  Future<void> _savePreferences() async {
    try {
      await _database.child('users/${widget.userId}/settings').set({
        'notificationsEnabled': _notificationsEnabled,
        'customMessage': _customMessage,
        'reminderFrequency': _reminderFrequency,
        'selectedLocation': _selectedLocation,
        'reminderHour': _reminderTime.hour,
        'reminderMinute': _reminderTime.minute,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Settings saved successfully!')),
      );
    } catch (e) {
      print('Error saving preferences: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving settings. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePreferences,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationToggle(
                title: 'Enable Notifications',
                initialValue: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              if (_notificationsEnabled) ...[
                TimePickerWidget(
                  initialTime: _reminderTime,
                  onTimeChanged: (time) {
                    setState(() {
                      _reminderTime = time;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Reminder Frequency',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<String>(
                  value: _reminderFrequency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _reminderFrequency = newValue!;
                    });
                  },
                  items: <String>['Hourly', 'Daily', 'Weekly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                LocationSelector(
                  onLocationSelected: (location) {
                    setState(() {
                      _selectedLocation = location;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Custom Reminder Message',
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your reminder message',
                  ),
                  controller: TextEditingController(text: _customMessage),
                  onChanged: (value) {
                    setState(() {
                      _customMessage = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Reminder set for ${_reminderTime.format(context)} at $_selectedLocation.\n'
                      'Frequency: $_reminderFrequency.\n'
                      'Message: $_customMessage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}