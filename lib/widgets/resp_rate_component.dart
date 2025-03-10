import 'package:flutter/material.dart';
import 'dart:async';

class RespRateComponent extends StatefulWidget {
  const RespRateComponent({Key? key}) : super(key: key);

  @override
  State<RespRateComponent> createState() => _RespRateComponentState();
}

class _RespRateComponentState extends State<RespRateComponent> {
  int respRate = 16;
  bool isIncreasing = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      setState(() {
        if (isIncreasing) {
          respRate += 1;
          if (respRate >= 20) {
            isIncreasing = false;
          }
        } else {
          respRate -= 1;
          if (respRate <= 12) {
            isIncreasing = true;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Top row with RESP label and max/min values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RESP',
                style: TextStyle(
                  color: Color(0xFF039BFC),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Right side - Max/Min values
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '30',
                    style: TextStyle(
                      color: Color(0xFF039BFC),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '8',
                    style: TextStyle(
                      color: Color(0xFF039BFC),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Centered value and bottom-right unit
          Expanded(
            child: Stack(
              children: [
                // Centered value
                Center(
                  child: Text(
                    respRate.toString(),
                    style: const TextStyle(
                      color: Color(0xFF039BFC),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Bottom-right unit
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Text(
                    '/min',
                    style: const TextStyle(
                      color: Color(0xFF039BFC),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 