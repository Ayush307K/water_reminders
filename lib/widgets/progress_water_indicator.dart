import 'package:flutter/material.dart';

class WaterProgressIndicator extends StatelessWidget {
  final double progress; // Value between 0.0 to 1.0
  final String label;

  WaterProgressIndicator({required this.progress, this.label = 'Water Intake'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Text(
              '${(progress * 100).toInt()}%', // Display percentage
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
