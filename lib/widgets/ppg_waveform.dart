import 'package:flutter/material.dart';
import 'dart:math' as math;

class PPGWaveform extends StatefulWidget {
  const PPGWaveform({super.key});

  @override
  State<PPGWaveform> createState() => _PPGWaveformState();
}

class _PPGWaveformState extends State<PPGWaveform> {
  final List<double> _data = [];
  final int maxDataPoints = 200;

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  void _generateData() {
    // Simulate PPG waveform data
    // PPG typically has a more rounded shape compared to ECG
    for (int i = 0; i < maxDataPoints; i++) {
      // Create a smoother sine wave for PPG simulation
      double value = math.sin(i * 0.1) * 0.7;
      // Add the characteristic PPG shape
      value = value * value * value * 30;
      _data.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      child: Stack(
        children: [
          // PPG Label and X1 text
          Positioned(
            left: 8,
            top: 8,


































































































            child: Row(
              children: [
                const Text(
                  'PPG',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'X1',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Waveform
          Positioned.fill(
            top: 30,
            child: CustomPaint(
              painter: PPGWaveformPainter(_data),
              size: const Size(double.infinity, double.infinity),
            ),
          ),
        ],
      ),
    );
  }
}

class PPGWaveformPainter extends CustomPainter {
  final List<double> data;

  PPGWaveformPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final middle = height / 2;

    if (data.isEmpty) return;

    path.moveTo(0, middle + data[0]);

    for (int i = 1; i < data.length; i++) {
      path.lineTo(
        (i * width) / data.length,
        middle + data[i],
      );
    }

    canvas.drawPath(path, paint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.red.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Vertical grid lines
    for (int i = 0; i < width; i += 50) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), height),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i < height; i += 25) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(width, i.toDouble()),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 