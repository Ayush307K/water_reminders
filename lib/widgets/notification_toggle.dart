import 'package:flutter/material.dart';

class NotificationToggle extends StatefulWidget {
  final String title;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  NotificationToggle({
    required this.title,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _NotificationToggleState createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: TextStyle(fontSize: 16)),
        Switch(
          value: _isEnabled,
          onChanged: (value) {
            setState(() {
              _isEnabled = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}
