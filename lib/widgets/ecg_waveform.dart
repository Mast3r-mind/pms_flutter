import 'package:flutter/material.dart';

class ECGWaveform extends StatelessWidget {
  const ECGWaveform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color ecgColor = const Color(0xFF00FD0C); // Bright green

    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black,
      child: Stack(
        children: [
          // Lead Label
          Positioned(
            left: 8,
            top: 8,
            child: Text(
              'I',
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // X5 Label
          Positioned(
            left: 40,
            top: 8,
            child: Text(
              'X5',
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Monitoring Label
          Positioned(
            left: 80,
            top: 8,
            child: Text(
              'Monitoring',
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Heart Icon
          Positioned(
            right: 45,
            top: 8,
            child: Icon(
              Icons.favorite,
              color: ecgColor,
              size: 16,
            ),
          ),
          // ECG Label
          Positioned(
            right: 8,
            top: 8,
            child: Text(
              'ECG',
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 