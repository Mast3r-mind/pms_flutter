class ECGPainter extends CustomPainter {
  final List<double> points;
  final Color color;
  final double strokeWidth;
  final Paint painter;

  ECGPainter({
    required this.points,
    required this.color,
    this.strokeWidth = 2.0,
  }) : painter = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final middle = height / 2;
    final pointWidth = width / (points.length - 1);

    // Start from left side
    path.moveTo(0, middle + (points.first * middle));

    // Draw points from left to right
    for (int i = 1; i < points.length; i++) {
      path.lineTo(i * pointWidth, middle + (points[i] * middle));
    }

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(ECGPainter oldDelegate) {
    return true;
  }
} 