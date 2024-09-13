import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/shared_preferences.dart';
import '../widgets/notification_toggle.dart';
import '../widgets/time_picker.dart';
import '../widgets/location_selector.dart';
import '../widgets/custom_text_field.dart';

class ReminderSettingsScreen extends StatefulWidget {
  @override
  _ReminderSettingsScreenState createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  bool _notificationsEnabled = false;
  TimeOfDay _reminderTime = TimeOfDay.now();
  String _selectedLocation = 'None';
  String _customMessage = '';
  String _reminderFrequency = 'Daily'; // Default frequency

  @override
  void initState() {
    super.initState();
    //_loadPreferences(); // Load saved preferences on start
  }


  void _loadPreferences() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    final prefs = await prefsService.loadPreferences();
    setState(() {
      _notificationsEnabled = prefs['notificationsEnabled'];
      _reminderTime = prefs['reminderTime'];
      _reminderFrequency = prefs['reminderFrequency'];
      _customMessage = prefs['customMessage'];
      _selectedLocation = prefs['selectedLocation'];
    });
  }


  // Save preferences to SharedPreferences
  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setString('customMessage', _customMessage);
    await prefs.setString('reminderFrequency', _reminderFrequency);
    await prefs.setString('selectedLocation', _selectedLocation);
    await prefs.setInt('reminderHour', _reminderTime.hour);
    await prefs.setInt('reminderMinute', _reminderTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Settings'),
        actions: [
      IconButton(
      icon: Icon(Icons.save),
      onPressed: () async {
        SharedPreferencesService prefsService = SharedPreferencesService();
        await prefsService.savePreferences(
          notificationsEnabled: _notificationsEnabled,
          reminderTime: _reminderTime,
          reminderFrequency: _reminderFrequency,
          customMessage: _customMessage,
          selectedLocation: _selectedLocation,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Settings saved!')),
        );
      },
    )

    ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enable Notifications Toggle
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

              // Reminder Time Picker
              if (_notificationsEnabled)
                TimePickerWidget(
                  initialTime: _reminderTime,
                  onTimeChanged: (time) {
                    setState(() {
                      _reminderTime = time;
                    });
                  },
                ),
              SizedBox(height: 20),

              // Reminder Frequency Dropdown
              if (_notificationsEnabled)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              SizedBox(height: 20),

              // Location Selector
              if (_notificationsEnabled)
                LocationSelector(
                  onLocationSelected: (location) {
                    setState(() {
                      _selectedLocation = location;
                    });
                  },
                ),
              SizedBox(height: 20),

              // Custom Reminder Message Input
              if (_notificationsEnabled)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Reminder Message',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your reminder message',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _customMessage = value;
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20),

              // Display the selected reminder settings
              if (_notificationsEnabled)
                Text(
                  'Reminder set for ${_reminderTime.format(context)} at $_selectedLocation.\n'
                      'Frequency: $_reminderFrequency.\n'
                      'Message: $_customMessage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

