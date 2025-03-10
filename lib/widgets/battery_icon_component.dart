import 'package:flutter/material.dart';

class BatteryIconComponent extends StatelessWidget {
  const BatteryIconComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,    // 898 - 840 = 58
      height: 50,   // 58 - 8 = 50
      child: const Icon(
        Icons.battery_full,  // Using built-in battery icon
        color: Colors.white,
        size: 36,
      ),
    );
  }
} 