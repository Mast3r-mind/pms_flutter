import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class HeartRateDetails extends StatefulWidget {
  const HeartRateDetails({super.key});

  @override
  State<HeartRateDetails> createState() => _HeartRateDetailsState();
}

class _HeartRateDetailsState extends State<HeartRateDetails> with SingleTickerProviderStateMixin {
  late AnimationController _ecgAnimationController;
  int _heartRate = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _ecgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _heartRate = (_heartRate + 1) % 121;
        if (_heartRate < 60) _heartRate = 60;
      });
    });
  }

  @override
  void dispose() {
    _ecgAnimationController.dispose();
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
        border: Border.all(
        //   color: const Color(0xFF559690),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HR Label and Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'HR',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '120',
                      style: TextStyle(
                        color: Color(0xFF00FF00),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '60',
                      style: TextStyle(
                        color: Color(0xFF00FF00),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Heart Rate Value
            Center(
              child: Text(
                _heartRate.toString(),
                style: const TextStyle(
                  color: Color(0xFF00FF00),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            // Bottom Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'ECG',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'bpm',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // ECG Waveform with clip
            ClipRect(
              child: SizedBox(
                height: 40,
                child: AnimatedBuilder(
                  animation: _ecgAnimationController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: ECGPainter(
                        progress: _ecgAnimationController.value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ECGPainter extends CustomPainter {
  final double progress;

  ECGPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FF00)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final segment = width / 3;
    final baseY = height / 2;

    canvas.clipRect(Rect.fromLTWH(0, 0, width, height));

    path.moveTo(0, baseY);

    final offset = progress * segment;
    final visibleSegments = (width / segment).ceil() + 1;

    for (int i = 0; i < visibleSegments; i++) {
      double x = (i * segment) + offset;
      
      if (x > width) break;

      path.lineTo(x + segment * 0.1, baseY - height * 0.05);
      path.quadraticBezierTo(
        x + segment * 0.15, 
        baseY - height * 0.05,
        x + segment * 0.2, 
        baseY
      );

      path.lineTo(x + segment * 0.25, baseY + height * 0.05);

      path.lineTo(x + segment * 0.3, baseY - height * 0.35);
      path.lineTo(x + segment * 0.35, baseY + height * 0.25);
      path.lineTo(x + segment * 0.4, baseY);

      path.lineTo(x + segment * 0.5, baseY + height * 0.15);
      path.quadraticBezierTo(
        x + segment * 0.6, 
        baseY + height * 0.15,
        x + segment * 0.7, 
        baseY
      );

      path.lineTo(x + segment, baseY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ECGPainter oldDelegate) => progress != oldDelegate.progress;
} 