import 'package:flutter/material.dart';
import 'dart:math' as math;

enum WaveformType {
  normal,
  tachycardia,
  bradycardia,
  atrialFibrillation,
  ventricularTachycardia,
  stElevation,
  heartBlock,
}

class AnimatedECGWaveform extends StatefulWidget {
  final Color color;
  final double height;
  final String title;
  final WaveformType waveformType;

  const AnimatedECGWaveform({
    super.key,
    required this.color,
    required this.height,
    required this.title,
    this.waveformType = WaveformType.normal,
  });

  @override
  State<AnimatedECGWaveform> createState() => _AnimatedECGWaveformState();
}

class _ECGPainter extends CustomPainter {
  final double progress;
  final Color color;
  final List<Offset> waveformPoints;
  final bool showGrid;

  _ECGPainter({
    required this.progress,
    required this.color,
    required this.waveformPoints,
    this.showGrid = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (showGrid) {
      _drawGrid(canvas, size);
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (waveformPoints.isEmpty) return;

    final path = Path();
    final pointsToDraw = (waveformPoints.length * progress).floor();
    
    if (pointsToDraw > 0) {
      path.moveTo(
        waveformPoints[0].dx * size.width,
        size.height / 2 - waveformPoints[0].dy * (size.height / 3),
      );

      for (int i = 1; i < pointsToDraw; i++) {
        final point = waveformPoints[i];
        path.lineTo(
          point.dx * size.width,
          size.height / 2 - point.dy * (size.height / 3),
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.green.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Draw vertical grid lines
    for (int i = 0; i <= 10; i++) {
      final x = size.width * i / 10;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    // Draw horizontal grid lines
    for (int i = 0; i <= 6; i++) {
      final y = size.height * i / 6;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ECGPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _AnimatedECGWaveformState extends State<AnimatedECGWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Offset> _waveformPoints = [];
  List<double> _ecgData = [];
  int currentDataIndex = 0;
  final int dataLength = 40;
  
  @override
  void initState() {
    super.initState();
    _generateRandomECGData();
    _generateWaveformPoints();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _updateWaveform();
          _controller.reset();
          _controller.forward();
        });
      }
    });
    _controller.forward();
  }

  void _generateRandomECGData() {
    // Initialize with 40 random ECG values
    _ecgData = List.generate(dataLength, (index) {
      // Generate random values within typical ECG ranges
      switch (index % 8) { // Simulate PQRST pattern
        case 0: return 0.0; // Baseline
        case 1: return 0.25 + _randomVariation(0.05); // P wave
        case 2: return 0.0 + _randomVariation(0.02); // PR segment
        case 3: return -0.2 + _randomVariation(0.05); // Q wave
        case 4: return 1.0 + _randomVariation(0.1); // R wave
        case 5: return -0.3 + _randomVariation(0.05); // S wave
        case 6: return 0.05 + _randomVariation(0.02); // ST segment
        case 7: return 0.3 + _randomVariation(0.05); // T wave
        default: return 0.0;
      }
    });
  }

  double _randomVariation(double maxVariation) {
    return (math.Random().nextDouble() * 2 - 1) * maxVariation;
  }

  void _updateECGData() {
    // Shift array and add new random values
    _ecgData.removeAt(0);
    double newValue = _ecgData.last + _randomVariation(0.1);
    newValue = newValue.clamp(-0.5, 1.2); // Keep within reasonable bounds
    _ecgData.add(newValue);
  }

  void _generateWaveformPoints() {
    _waveformPoints.clear();
    double x = 0.0;
    final dx = 1.0 / (_ecgData.length - 1);

    for (int i = 0; i < _ecgData.length; i++) {
      _waveformPoints.add(Offset(x, _ecgData[i]));
      x += dx;
    }
  }

  void _updateWaveform() {
    _updateECGData();
    _generateWaveformPoints();
    currentDataIndex = (currentDataIndex + 1) % dataLength;
  }

  void updateWithNewData(List<double> newData) {
    if (newData.length == dataLength) {
      setState(() {
        _ecgData = List.from(newData);
        _generateWaveformPoints();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.black,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _ECGPainter(
              progress: _controller.value,
              color: widget.color,
              waveformPoints: _waveformPoints,
              showGrid: true, // Optional grid background
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 