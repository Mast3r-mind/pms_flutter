import 'package:flutter/material.dart';

class ECGWaveformPainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final Paint _paint;

  ECGWaveformPainter({
    required this.animationValue,
    required this.color,
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
    
    // Calculate sweep position
    final sweepX = animationValue * width;
    
    // Draw background grid (optional)
    _drawGrid(canvas, size);
    
    // Draw the ECG waveform up to sweep position
    if (sweepX > 0) {
      path.moveTo(0, centerY);
      
      double x = 0;
      while (x < sweepX) {
        // P wave
        path.lineTo(x + 30, centerY);
        if (x + 30 > sweepX) break;
        
        // PR segment
        path.lineTo(x + 60, centerY);
        if (x + 60 > sweepX) break;
        
        // QRS complex
        path.lineTo(x + 65, centerY - 2);
        if (x + 65 > sweepX) break;
        path.lineTo(x + 70, centerY - 30);
        if (x + 70 > sweepX) break;
        path.lineTo(x + 75, centerY + 45);
        if (x + 75 > sweepX) break;
        path.lineTo(x + 80, centerY);
        if (x + 80 > sweepX) break;
        
        // ST segment and T wave
        path.lineTo(x + 100, centerY);
        if (x + 100 > sweepX) break;
        path.quadraticBezierTo(
          x + 150, centerY + 15,
          x + 200, centerY
        );
        if (x + 200 > sweepX) break;
        
        x += 200; // Move to next cycle
      }
    }
    
    canvas.drawPath(path, _paint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 0.5;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint
      );
    }
  }

  @override
  bool shouldRepaint(ECGWaveformPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
} 