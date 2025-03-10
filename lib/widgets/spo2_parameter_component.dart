import 'package:flutter/material.dart';
import 'dart:async';

class SpO2ParameterComponent extends StatefulWidget {
  const SpO2ParameterComponent({Key? key}) : super(key: key);

  @override
  State<SpO2ParameterComponent> createState() => _SpO2ParameterComponentState();
}

class _SpO2ParameterComponentState extends State<SpO2ParameterComponent> {
  int spo2Value = 98;
  int pulseRate = 60;
  double perfusionIndex = 12.0;
  bool isIncreasing = true;
  Timer? timer;
  final int spo2MaxValue = 120;
  final int spo2MinValue = 90;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (isIncreasing) {
          pulseRate += 1;
          if (pulseRate >= 65) {
            isIncreasing = false;
          }
        } else {
          pulseRate -= 1;
          if (pulseRate <= 55) {
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
      width: 280,
      height: 139,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: const Color(0xFF000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          // SpO2 Label
          Positioned(
            left: 16,
            top: 8,
            child: const Text(
              'SpO2',
              style: TextStyle(
                color: Color(0xFFFFFF00),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // PR Label
          Positioned(
            left: 16,
            bottom: 12,
            child: const Text(
              'PR',
              style: TextStyle(
                color: Color(0xFFFFFF00),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // PR Value
          Positioned(
            left: 50,
            bottom: 12,
            child: Text(
              pulseRate.toString(),
              style: const TextStyle(
                color: Color(0xFFFFFF00),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // PI Label and Value
          Positioned(
            left: 120,
            bottom: 12,
            child: Row(
              children: [
                const Text(
                  'PI ',
                  style: TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  perfusionIndex.toString(),
                  style: const TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Percentage symbol
          Positioned(
            right: 16,
            bottom: 12,
            child: const Text(
              '%',
              style: TextStyle(
                color: Color(0xFFFFFF00),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // SpO2 Value (Large, centered)
          Positioned(
            left: 0,
            right: 0,
            top: 35,
            child: Center(
              child: Text(
                spo2Value.toString(),
                style: const TextStyle(
                  color: Color(0xFFFFFF00),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Max/Min Values with minimal spacing
          Positioned(
            right: 16,
            top: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  spo2MaxValue.toString(),
                  style: const TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  spo2MinValue.toString(),
                  style: const TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
 