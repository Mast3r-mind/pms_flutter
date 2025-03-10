import 'package:flutter/material.dart';
import 'dart:async';

class TemperatureComponent extends StatefulWidget {
  const TemperatureComponent({Key? key}) : super(key: key);

  @override
  State<TemperatureComponent> createState() => _TemperatureComponentState();
}

class _TemperatureComponentState extends State<TemperatureComponent> {
  double t1Value = 37.0;
  double t2Value = 37.5;
  double deltaT = 0.5;
  bool isIncreasing = true;
  Timer? timer;
  final double tempMaxValue = 38.0;
  final double tempMinValue = 35.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      setState(() {
        if (isIncreasing) {
          t1Value += 0.1;
          t2Value += 0.1;
          if (t1Value >= 37.2) {
            isIncreasing = false;
          }
        } else {
          t1Value -= 0.1;
          t2Value -= 0.1;
          if (t1Value <= 36.8) {
            isIncreasing = true;
          }
        }
        t1Value = double.parse(t1Value.toStringAsFixed(1));
        t2Value = double.parse(t2Value.toStringAsFixed(1));
        deltaT = double.parse((t2Value - t1Value).toStringAsFixed(1));
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
      height: 141,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: const Color(0xFF000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // T1 Label
          Positioned(
            left: 16,
            top: 8,
            child: const Text(
              'T1',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // T2 Label
          Positioned(
            left: 140,
            top: 8,
            child: const Text(
              'T2',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // T1 Value
          Positioned(
            left: 16,
            top: 35,
            child: Text(
              t1Value.toStringAsFixed(1),
              style: const TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // T2 Value
          Positioned(
            left: 140,
            top: 35,
            child: Text(
              t2Value.toStringAsFixed(1),
              style: const TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Max/Min Values
          Positioned(
            right: 16,
            top: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tempMaxValue.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  tempMinValue.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Delta T Label and Value
          Positioned(
            left: 16,
            bottom: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text(
                  'ΔT ',
                  style: TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                ),
                Text(
                  deltaT.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                ),
              ],
            ),
          ),
          // °C symbol at bottom right
          Positioned(
            right: 16,
            bottom: 16,
            child: const Text(
              '°C',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 