import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  TimePickerWidget({
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.onTimeChanged(_selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Reminder Time: ${_selectedTime.format(context)}",
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.access_time, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
