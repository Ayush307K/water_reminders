import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _notificationsEnabledKey = 'notificationsEnabled';
  static const String _reminderHourKey = 'reminderHour';
  static const String _reminderMinuteKey = 'reminderMinute';
  static const String _reminderFrequencyKey = 'reminderFrequency';
  static const String _customMessageKey = 'customMessage';
  static const String _selectedLocationKey = 'selectedLocation';

  // Load preferences from SharedPreferences
  Future<Map<String, dynamic>> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationsEnabled = prefs.getBool(_notificationsEnabledKey) ?? false;
    String reminderFrequency = prefs.getString(_reminderFrequencyKey) ?? 'Daily';
    String customMessage = prefs.getString(_customMessageKey) ?? '';
    String selectedLocation = prefs.getString(_selectedLocationKey) ?? 'None';
    int hour = prefs.getInt(_reminderHourKey) ?? TimeOfDay.now().hour;
    int minute = prefs.getInt(_reminderMinuteKey) ?? TimeOfDay.now().minute;
    TimeOfDay reminderTime = TimeOfDay(hour: hour, minute: minute);

    return {
      'notificationsEnabled': notificationsEnabled,
      'reminderTime': reminderTime,
      'reminderFrequency': reminderFrequency,
      'customMessage': customMessage,
      'selectedLocation': selectedLocation,
    };
  }

  // Save preferences to SharedPreferences
  Future<void> savePreferences({
    required bool notificationsEnabled,
    required TimeOfDay reminderTime,
    required String reminderFrequency,
    required String customMessage,
    required String selectedLocation,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, notificationsEnabled);
    await prefs.setInt(_reminderHourKey, reminderTime.hour);
    await prefs.setInt(_reminderMinuteKey, reminderTime.minute);
    await prefs.setString(_reminderFrequencyKey, reminderFrequency);
    await prefs.setString(_customMessageKey, customMessage);
    await prefs.setString(_selectedLocationKey, selectedLocation);
  }
}
