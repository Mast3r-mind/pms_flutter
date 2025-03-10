import 'package:flutter/material.dart';

class HRTabContent extends StatefulWidget {
  const HRTabContent({Key? key}) : super(key: key);

  @override
  State<HRTabContent> createState() => _HRTabContentState();
}

class _HRTabContentState extends State<HRTabContent> {
  int lowerLimit = 60;
  int upperLimit = 120;
  bool stAlarmEnabled = true;

  Widget _buildNumberControl(bool isUpper) {
    final value = isUpper ? upperLimit : lowerLimit;

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
              onPressed: () {
                setState(() {
                  if (isUpper) {
                    if (upperLimit > lowerLimit + 1) upperLimit--;
                  } else {
                    if (lowerLimit > 30) lowerLimit--;
                  }
                });
              },
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
              onPressed: () {
                setState(() {
                  if (isUpper) {
                    if (upperLimit < 200) upperLimit++;
                  } else {
                    if (lowerLimit < upperLimit - 1) lowerLimit++;
                  }
                });
              },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lower Limit',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 100),
              const Text(
                'Upper Limit',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text(
                'HR:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 16),
              _buildNumberControl(false),
              const SizedBox(width: 32),
              _buildNumberControl(true),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text(
                'ST Alarm:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<bool>(
                  value: stAlarmEnabled,
                  dropdownColor: const Color(0xFF2A2A2A),
                  style: const TextStyle(color: Colors.white),
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('ON'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('OFF'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      stAlarmEnabled = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 