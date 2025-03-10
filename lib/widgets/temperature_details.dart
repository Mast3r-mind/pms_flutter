import 'package:flutter/material.dart';
import 'dart:async';

class TemperatureDetails extends StatefulWidget {
  const TemperatureDetails({super.key});

  @override
  State<TemperatureDetails> createState() => _TemperatureDetailsState();
}

class _TemperatureDetailsState extends State<TemperatureDetails> {
  double _temp1 = 35.0;  // Starting from minimum
  double _temp2 = 35.5;  // Starting from minimum + 0.5
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // Increment temperature 1 between 35.0 and 38.0
        _temp1 += 0.1;
        if (_temp1 > 38.0) {
          _temp1 = 35.0;
        }

        // Increment temperature 2 between 35.5 and 38.5
        _temp2 += 0.1;
        if (_temp2 > 38.5) {
          _temp2 = 35.5;
        }

        // Round to 1 decimal place
        _temp1 = double.parse(_temp1.toStringAsFixed(1));
        _temp2 = double.parse(_temp2.toStringAsFixed(1));
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tempDiff = (_temp2 - _temp1).abs().toStringAsFixed(1);

    return Container(
      width: 330,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // T1 Label and Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'T₁',
                  style: TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '38.0',
                      style: TextStyle(
                        color: Color(0xFF00FFFF),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '35.0',
                      style: TextStyle(
                        color: Color(0xFF00FFFF),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Temperature 1 Value
            Center(
              child: Text(
                _temp1.toStringAsFixed(1),
                style: const TextStyle(
                  color: Color(0xFF00FFFF),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // T2 Label
            const Text(
              'T₂',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Temperature 2 Value
            Center(
              child: Text(
                _temp2.toStringAsFixed(1),
                style: const TextStyle(
                  color: Color(0xFF00FFFF),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            // Temperature Difference
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ΔT - $tempDiff',
                  style: const TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '°C',
                  style: TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 