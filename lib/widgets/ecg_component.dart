import 'package:flutter/material.dart';
import 'dart:math' as math;

class ECGComponent extends StatefulWidget {
  final String leadLabel;
  final bool isLeadOne;

  const ECGComponent({
    Key? key, 
    this.leadLabel = 'II',
    this.isLeadOne = false,
  }) : super(key: key);

  @override
  State<ECGComponent> createState() => _ECGComponentState();
}

class _ECGComponentState extends State<ECGComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Color ecgColor = const Color(0xFF00FD0C); // Bright green

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black,
      child: Stack(
        children: [
          // Lead Label (I or II)
          Positioned(
            left: 8,
            top: 8,
            child: Text(
              widget.leadLabel,
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // X5 Label
          if (widget.isLeadOne)
            Positioned(
              left: 40,
              top: 8,
              child: Text(
                'X5',
                style: TextStyle(
                  color: ecgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          // Monitoring Label
          if (widget.isLeadOne)
            Positioned(
              left: 80,
              top: 8,
              child: Text(
                'Monitoring',
                style: TextStyle(
                  color: ecgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          // Heart Icon
          Positioned(
            right: 45,
            top: 8,
            child: Icon(
              Icons.favorite,
              color: ecgColor,
              size: 16,
            ),
          ),
          // ECG Label
          Positioned(
            right: 8,
            top: 8,
            child: Text(
              'ECG',
              style: TextStyle(
                color: ecgColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Animated Waveform
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: ECGWaveformPainter(
                  progress: _animationController.value,
                  color: ecgColor,
                  isLeadOne: widget.isLeadOne,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ECGWaveformPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool isLeadOne;
  final Paint _paint;

  ECGWaveformPainter({
    required this.progress,
    required this.color,
    required this.isLeadOne,
  }) : _paint = Paint()
    ..color = color
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerY = height * 0.5;
    
    final startX = -progress * width;
    
    for (double x = startX; x < width + 100; x += 200) {
      path.moveTo(x, centerY);
      path.lineTo(x + 30, centerY);
      
      if (isLeadOne) {
        // Lead I waveform pattern
        path.lineTo(x + 60, centerY);
        path.lineTo(x + 65, centerY - 2);
        path.lineTo(x + 70, centerY - 15); // Smaller R wave
        path.lineTo(x + 75, centerY + 30); // Shallower S wave
        path.lineTo(x + 80, centerY);
      } else {
        // Lead II waveform pattern
        path.lineTo(x + 60, centerY);
        path.lineTo(x + 65, centerY - 2);
        path.lineTo(x + 70, centerY - 20);
        path.lineTo(x + 75, centerY + 40);
        path.lineTo(x + 80, centerY);
      }
      
      path.lineTo(x + 200, centerY);
    }
    
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(ECGWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isLeadOne != isLeadOne;
  }
}

// Usage example:
// For Lead I:
// ECGComponent(leadLabel: 'I', isLeadOne: true)
// 
// For Lead II:
// ECGComponent(leadLabel: 'II', isLeadOne: false) 