import 'package:flutter/material.dart';

class StatusBarComponent extends StatelessWidget {
  const StatusBarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 812, top: 18),
      child: Row(
        children: [
          // WiFi Icon
          const Icon(
            Icons.wifi,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 10),
          // Battery Icons
          const Icon(
            Icons.battery_full,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.battery_full,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 10),
          // Date and Time
          Text(
            '08-08-2024\n01:20PM',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.2,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}