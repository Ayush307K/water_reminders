import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  final ValueChanged<String> onLocationSelected;

  LocationSelector({required this.onLocationSelected});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String _selectedLocation = 'None';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLocation,
      onChanged: (String? newValue) {
        setState(() {
          _selectedLocation = newValue!;
          widget.onLocationSelected(_selectedLocation);
        });
      },
      items: <String>['None', 'Home', 'Work', 'Gym']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
