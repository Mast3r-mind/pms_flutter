import 'package:flutter/material.dart';
import 'dart:async';

class NIBPComponent extends StatefulWidget {
  const NIBPComponent({Key? key}) : super(key: key);

  @override
  State<NIBPComponent> createState() => _NIBPComponentState();
}

class _NIBPComponentState extends State<NIBPComponent> {
  int systolic = 120;
  int diastolic = 80;
  bool isIncreasing = true;
  Timer? timer;
  final int systolicMaxValue = 160;
  final int systolicMinValue = 90;
  final int diastolicMaxValue = 90;
  final int diastolicMinValue = 50;
  final int meanMaxValue = 110;
  final int meanMinValue = 70;

  int get meanPressure => ((2 * diastolic) + systolic) ~/ 3;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (isIncreasing) {
          systolic += 1;
          diastolic += 1;
          if (systolic >= 139) {
            isIncreasing = false;
          }
        } else {
          systolic -= 1;
          diastolic -= 1;
          if (systolic <= 120) {
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
      width: 281,
      height: 182,
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
          // NIBP Label
          Positioned(
            left: 16,
            top: 8,
            child: const Text(
              'NIBP',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Left column (Systolic values)
          Positioned(
            left: 16,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  systolicMaxValue.toString(),
                  style: TextStyle(
                    color: systolic > systolicMaxValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  systolicMinValue.toString(),
                  style: TextStyle(
                    color: systolic < systolicMinValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Mean values (positioned higher from bottom)
          Positioned(
            left: 16,
            bottom: 35, // Moved up from 12
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meanMaxValue.toString(),
                  style: TextStyle(
                    color: meanPressure > meanMaxValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  meanMinValue.toString(),
                  style: TextStyle(
                    color: meanPressure < meanMinValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Right column (Diastolic values)
          Positioned(
            right: 16,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  diastolicMaxValue.toString(),
                  style: TextStyle(
                    color: diastolic > diastolicMaxValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  diastolicMinValue.toString(),
                  style: TextStyle(
                    color: diastolic < diastolicMinValue ? Colors.red : Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Center Blood Pressure Values
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$systolic/$diastolic',
                  style: TextStyle(
                    color: (systolic > systolicMaxValue || systolic < systolicMinValue ||
                           diastolic > diastolicMaxValue || diastolic < diastolicMinValue)
                        ? Colors.red
                        : Color(0xFFFFFFFF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  '(${meanPressure})',
                  style: TextStyle(
                    color: (meanPressure > meanMaxValue || meanPressure < meanMinValue)
                        ? Colors.red
                        : Color(0xFFFFFFFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // mmHg Label
          Positioned(
            right: 16,
            bottom: 12,
            child: const Text(
              'mmHg',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 