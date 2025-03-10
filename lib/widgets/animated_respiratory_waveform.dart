import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedRespiratoryWaveform extends StatefulWidget {
  final Color waveColor;
  final double height;
  final double width;
  final bool isAnimating;

  const AnimatedRespiratoryWaveform({
    Key? key,
    required this.waveColor,
    required this.height,
    required this.width,
    this.isAnimating = true,
  }) : super(key: key);

  @override
  State<AnimatedRespiratoryWaveform> createState() => _AnimatedRespiratoryWaveformState();
}

class _AnimatedRespiratoryWaveformState extends State<AnimatedRespiratoryWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _waveformPoints = [];
  
  void _generateWaveformPoints() {
    _waveformPoints.clear();
    double x = 0.0;
    double dx = 0.005; // Smaller dx for smoother curve
    _generateRespiratoryWave(x, dx);
  }

  void _generateRespiratoryWave(double x, double dx) {
    double breathPeriod = 1.0;
    int pointsPerBreath = (breathPeriod / dx).round();
    
    while (x < 1.0) {
      // Increased frequency by adjusting the angle multiplier from 2 to 3
      double angle = (x * 2 * math.pi) * 3; // Changed multiplier to 3 for faster waves
      double height = math.sin(angle) * 0.8;
      
      _waveformPoints.add(Offset(x, height));
      x += dx;
    }
  }

  @override
  void initState() {
    super.initState();
    _generateWaveformPoints();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000), // Reduced from 8000 to 5000 for faster animation
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _RespiratoryWaveformPainter(
            points: _waveformPoints,
            progress: widget.isAnimating ? _controller.value : 0,
            waveColor: widget.waveColor,
          ),
        );
      },
    );
  }
}

class _RespiratoryWaveformPainter extends CustomPainter {
  final List<Offset> points;
  final double progress;
  final Color waveColor;

  _RespiratoryWaveformPainter({
    required this.points,
    required this.progress,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (points.isEmpty) return;

    final path = Path();
    final stepSize = size.width / (points.length - 1);
    final heightScale = size.height / 2;
    final centerY = size.height / 2;

    int startIndex = points.length - ((progress * points.length).floor() % points.length) - 1;
    path.moveTo(0, centerY + (points[startIndex].dy * heightScale));

    for (int i = 1; i < points.length; i++) {
      final pointIndex = (startIndex + i) % points.length;
      path.lineTo(
        i * stepSize,
        centerY + (points[pointIndex].dy * heightScale),
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RespiratoryWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.waveColor != waveColor;
  }
} 