import 'package:flutter/material.dart';

class RRTabContent extends StatefulWidget {
  const RRTabContent({Key? key}) : super(key: key);

  @override
  State<RRTabContent> createState() => _RRTabContentState();
}

class _RRTabContentState extends State<RRTabContent> {
  int lowerLimit = 8;
  int upperLimit = 30;

  void _incrementLimit(bool isUpper) {
    setState(() {
      if (isUpper) {
        if (upperLimit < 50) upperLimit++;
      } else {
        if (lowerLimit < upperLimit - 1) lowerLimit++;
      }
    });
  }

  void _decrementLimit(bool isUpper) {
    setState(() {
      if (isUpper) {
        if (upperLimit > lowerLimit + 1) upperLimit--;
      } else {
        if (lowerLimit > 5) lowerLimit--;
      }
    });
  }

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
              onPressed: () => _decrementLimit(isUpper),
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
              onPressed: () => _incrementLimit(isUpper),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Labels row
          Row(
            children: [
              const SizedBox(width: 80),
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
          // Controls row
          Row(
            children: [
              const Text(
                'RR:',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              _buildNumberControl(false),
              const SizedBox(width: 100),
              _buildNumberControl(true),
            ],
          ),
        ],
      ),
    );
  }
} 