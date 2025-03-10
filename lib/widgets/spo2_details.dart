import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SPO2Details extends StatefulWidget {
  const SPO2Details({super.key});

  @override
  State<SPO2Details> createState() => _SPO2DetailsState();
}

class _SPO2DetailsState extends State<SPO2Details> with SingleTickerProviderStateMixin {
  late AnimationController _waveformController;
  int _spo2Value = 95;  // Starting from minimum
  int _prValue = 55;    // Starting from minimum
  double _piValue = 8.0; // Starting from minimum
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _waveformController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // Increment SPO2 between 95 and 100
        _spo2Value += 1;
        if (_spo2Value > 100) {
          _spo2Value = 95;
        }

        // Increment PR between 55 and 65
        _prValue += 1;
        if (_prValue > 65) {
          _prValue = 55;
        }

        // Increment PI between 8.0 and 16.0
        _piValue += 0.5;
        if (_piValue > 16.0) {
          _piValue = 8.0;
        }
        
        // Round PI to 1 decimal place
        _piValue = double.parse(_piValue.toStringAsFixed(1));
      });
    });
  }

  @override
  void dispose() {
    _waveformController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SpO₂',
                  style: TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 20,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFFFF00)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '120',
                        style: TextStyle(
                          color: Color(0xFFFFFF00),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '90',
                        style: TextStyle(
                          color: Color(0xFFFFFF00),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _spo2Value.toString(),
                style: const TextStyle(
                  color: Color(0xFFFFFF00),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PR',
                      style: TextStyle(
                        color: Color(0xFFFFFF00),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _prValue.toString(),
                      style: const TextStyle(
                        color: Color(0xFFFFFF00),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PI',
                      style: TextStyle(
                        color: Color(0xFFFFFF00),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _piValue.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xFFFFFF00),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '%',
                  style: TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Pleth',
              style: TextStyle(
                color: Color(0xFFFFFF00),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: AnimatedBuilder(
                animation: _waveformController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: PlethWaveformPainter(
                      progress: _waveformController.value,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlethWaveformPainter extends CustomPainter {
  final double progress;

  PlethWaveformPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFFF00)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    
    canvas.clipRect(Rect.fromLTWH(0, 0, width, height));

    final wavelength = width / 4;
    final amplitude = height / 3;
    
    path.moveTo(0, height / 2);

    for (double x = 0; x < width + wavelength; x++) {
      final currentProgress = (x - progress * wavelength) / wavelength;
      final y = height / 2 + amplitude * sin(currentProgress * 2 * pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PlethWaveformPainter oldDelegate) =>
      progress != oldDelegate.progress;
} 