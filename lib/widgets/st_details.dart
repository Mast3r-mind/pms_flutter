import 'package:flutter/material.dart';

class STDetails extends StatefulWidget {
  const STDetails({super.key});

  @override
  State<STDetails> createState() => _STDetailsState();
}

class _STDetailsState extends State<STDetails> with SingleTickerProviderStateMixin {
  late AnimationController _waveformController;
  final Map<String, double> _stValues = {
    'I': 0.08,
    'II': 0.10,
    'III': 0.02,
    'aVR': -0.09,
    'aVL': -0.06,
    'aVF': -0.03,
    'V': 0.04,
  };

  @override
  void initState() {
    super.initState();
    _waveformController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _waveformController.dispose();
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
            const Text(
              'ST',
              style: TextStyle(
                color: Color(0xFF00FF00),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // First row of ST values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSTValue('I', _stValues['I']!),
                _buildSTValue('aVR', _stValues['aVR']!),
                _buildSTValue('V', _stValues['V']!),
              ],
            ),
            const SizedBox(height: 8),
            // Second row of ST values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSTValue('II', _stValues['II']!),
                _buildSTValue('aVL', _stValues['aVL']!),
              ],
            ),
            const SizedBox(height: 8),
            // Third row of ST values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSTValue('III', _stValues['III']!),
                _buildSTValue('aVF', _stValues['aVF']!),
                const Text(
                  'mV',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // ECG Waveform
            SizedBox(
              height: 100,
              child: AnimatedBuilder(
                animation: _waveformController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: ECGWaveformPainter(
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

  Widget _buildSTValue(String lead, double value) {
    return Row(
      children: [
        Text(
          lead,
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class ECGWaveformPainter extends CustomPainter {
  final double progress;

  ECGWaveformPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FF00)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final midY = height / 2;

    // Calculate the sweep position
    final sweepX = width * progress;

    // Draw the baseline
    path.moveTo(0, midY);
    
    // Draw the ECG pattern up to the sweep position
    if (sweepX > width * 0.1) path.lineTo(width * 0.1, midY); // Baseline
    if (sweepX > width * 0.15) path.lineTo(width * 0.15, midY - height * 0.1); // P wave
    if (sweepX > width * 0.2) path.lineTo(width * 0.2, midY); // Back to baseline
    if (sweepX > width * 0.25) path.lineTo(width * 0.25, midY); // PR segment
    if (sweepX > width * 0.3) path.lineTo(width * 0.3, midY - height * 0.5); // QRS up
    if (sweepX > width * 0.35) path.lineTo(width * 0.35, midY + height * 0.2); // QRS down
    if (sweepX > width * 0.4) path.lineTo(width * 0.4, midY); // Back to baseline
    if (sweepX > width * 0.45) path.lineTo(width * 0.45, midY + height * 0.1); // T wave
    if (sweepX > width * 0.5) path.lineTo(width * 0.5, midY); // End at baseline
    if (sweepX > width * 0.5) path.lineTo(sweepX, midY); // Sweep line

    canvas.drawPath(path, paint);

    // Draw vertical sweep line
    canvas.drawLine(
      Offset(sweepX, 0),
      Offset(sweepX, height),
      paint..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(ECGWaveformPainter oldDelegate) =>
      progress != oldDelegate.progress;
} 