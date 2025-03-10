import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedPPGWaveform extends StatefulWidget {
  final Color waveColor;
  final double height;
  final double width;
  final bool isAnimating;

  const AnimatedPPGWaveform({
    Key? key,
    required this.waveColor,
    required this.height,
    required this.width,
    this.isAnimating = true,
  }) : super(key: key);

  @override
  State<AnimatedPPGWaveform> createState() => _AnimatedPPGWaveformState();
}

class _AnimatedPPGWaveformState extends State<AnimatedPPGWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _waveformPoints = [];
  
  void _generateWaveformPoints() {
    _waveformPoints.clear();
    double x = 0.0;
    double dx = 0.005;
    _generatePPGWave(x, dx);
  }

  void _generatePPGWave(double x, double dx) {
    double beatPeriod = 1.0;
    int pointsPerBeat = (beatPeriod / dx).round();
    
    while (x < 1.0) {
      // Baseline
      for (int i = 0; i < pointsPerBeat ~/ 12; i++) {
        _waveformPoints.add(Offset(x, 0.1));
        x += dx;
      }

      // Initial rapid upstroke
      for (int i = 0; i < pointsPerBeat ~/ 30; i++) {
        double factor = math.pow(i / (pointsPerBeat ~/ 30), 0.8).toDouble();
        _waveformPoints.add(Offset(x, 0.1 + (0.8 * factor)));
        x += dx;
      }

      // Systolic peak (more pointed)
      for (int i = 0; i < pointsPerBeat ~/ 25; i++) {
        double progress = i / (pointsPerBeat ~/ 25);
        double height = 0.9 - (0.1 * progress);
        _waveformPoints.add(Offset(x, height));
        x += dx;
      }

      // Dicrotic notch and dicrotic wave
      for (int i = 0; i < pointsPerBeat ~/ 10; i++) {
        double progress = i / (pointsPerBeat ~/ 10);
        double notchDepth = 0.15;
        double notchPosition = 0.3;
        double notchWidth = 0.2;
        
        if (progress < notchPosition) {
          // Downslope before notch
          double slope = 1.0 - (progress / notchPosition);
          _waveformPoints.add(Offset(x, 0.8 * slope + 0.1));
        } else if (progress < notchPosition + notchWidth) {
          // Dicrotic notch
          double notchProgress = (progress - notchPosition) / notchWidth;
          double notchShape = math.sin(notchProgress * math.pi);
          _waveformPoints.add(Offset(x, 0.3 - (notchDepth * notchShape)));
        } else {
          // Dicrotic wave and return to baseline
          double waveProgress = (progress - (notchPosition + notchWidth)) / (1 - (notchPosition + notchWidth));
          double waveHeight = 0.3 * (1 - waveProgress);
          _waveformPoints.add(Offset(x, 0.3 - waveHeight));
        }
        x += dx;
      }

      // Return to baseline
      for (int i = 0; i < pointsPerBeat ~/ 8; i++) {
        double factor = i / (pointsPerBeat ~/ 8);
        _waveformPoints.add(Offset(x, 0.2 - (0.1 * factor)));
        x += dx;
      }

      // Extended baseline until next beat
      for (int i = 0; i < pointsPerBeat ~/ 6; i++) {
        _waveformPoints.add(Offset(x, 0.1));
        x += dx;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _generateWaveformPoints();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
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
          painter: _PPGWaveformPainter(
            points: _waveformPoints,
            progress: widget.isAnimating ? _controller.value : 0,
            waveColor: widget.waveColor,
          ),
        );
      },
    );
  }
}

class _PPGWaveformPainter extends CustomPainter {
  final List<Offset> points;
  final double progress;
  final Color waveColor;

  _PPGWaveformPainter({
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
  bool shouldRepaint(_PPGWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.waveColor != waveColor;
  }
} 