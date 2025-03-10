import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveformWidget extends StatelessWidget {
  final String title;
  final Color color;
  final double height;
  final double width;
  final bool showTitle;

  const WaveformWidget({
    super.key,
    required this.title,
    required this.color,
    required this.height,
    required this.width,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (showTitle)
            Container(
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              color: color.withOpacity(0.3),
              child: Text(
                title,
                style: TextStyle(color: color),
              ),
            ),
          Expanded(
            child: CustomPaint(
              painter: WaveformPainter(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final Color color;

  WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);
    
    for (double x = 0; x < size.width; x += 10) {
      path.lineTo(x, size.height / 2 + math.sin(x * 0.1) * 20);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 