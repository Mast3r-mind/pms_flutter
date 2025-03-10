import 'package:flutter/material.dart';

class NIBPTabContent extends StatefulWidget {
  const NIBPTabContent({Key? key}) : super(key: key);

  @override
  State<NIBPTabContent> createState() => _NIBPTabContentState();
}

class _NIBPTabContentState extends State<NIBPTabContent> {
  // Systolic limits
  int systolicLower = 90;
  int systolicUpper = 160;

  // Diastolic limits
  int diastolicLower = 50;
  int diastolicUpper = 90;

  // Mean limits
  int meanLower = 60;
  int meanUpper = 110;

  void _incrementLimit(String type, bool isUpper) {
    setState(() {
      switch (type) {
        case 'systolic':
          if (isUpper) {
            if (systolicUpper < 200) systolicUpper++;
          } else {
            if (systolicLower < systolicUpper - 1) systolicLower++;
          }
          break;
        case 'diastolic':
          if (isUpper) {
            if (diastolicUpper < 120) diastolicUpper++;
          } else {
            if (diastolicLower < diastolicUpper - 1) diastolicLower++;
          }
          break;
        case 'mean':
          if (isUpper) {
            if (meanUpper < 130) meanUpper++;
          } else {
            if (meanLower < meanUpper - 1) meanLower++;
          }
          break;
      }
    });
  }

  void _decrementLimit(String type, bool isUpper) {
    setState(() {
      switch (type) {
        case 'systolic':
          if (isUpper) {
            if (systolicUpper > systolicLower + 1) systolicUpper--;
          } else {
            if (systolicLower > 40) systolicLower--;
          }
          break;
        case 'diastolic':
          if (isUpper) {
            if (diastolicUpper > diastolicLower + 1) diastolicUpper--;
          } else {
            if (diastolicLower > 20) diastolicLower--;
          }
          break;
        case 'mean':
          if (isUpper) {
            if (meanUpper > meanLower + 1) meanUpper--;
          } else {
            if (meanLower > 30) meanLower--;
          }
          break;
      }
    });
  }

  Widget _buildNumberControl(String type, bool isUpper) {
    final value = isUpper 
        ? (type == 'systolic' ? systolicUpper 
          : type == 'diastolic' ? diastolicUpper 
          : meanUpper)
        : (type == 'systolic' ? systolicLower 
          : type == 'diastolic' ? diastolicLower 
          : meanLower);

    return Container(
      width: 90,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minus button with green background
          Container(
            width: 25,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF006C58),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove, color: Colors.white, size: 20),
              onPressed: () => _decrementLimit(type, isUpper),
            ),
          ),
          // Value display with dark grey background
          Container(
            width: 40,
            height: 36,
            color: const Color(0xFF2A2A2A),
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Plus button with green background
          Container(
            width: 25,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF006C58),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () => _incrementLimit(type, isUpper),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Labels row
          Row(
            children: [
              const SizedBox(width: 80), // Increased from 60 to 80
              const Text(
                'Lower Limit',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 120),
              const Text(
                'Upper Limit',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Systolic controls
          Row(
            children: [
              const Text(
                'Systolic:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 16),
              _buildNumberControl('systolic', false),
              const SizedBox(width: 140),
              _buildNumberControl('systolic', true),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text(
                'Diastolic:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 16),
              _buildNumberControl('diastolic', false),
              const SizedBox(width: 140),
              _buildNumberControl('diastolic', true),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text(
                'Mean:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 43),
              _buildNumberControl('mean', false),
              const SizedBox(width: 140),
              _buildNumberControl('mean', true),
            ],
          ),
        ],
      ),
    );
  }
} 