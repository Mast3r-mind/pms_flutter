import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class RespiratoryRateDetails extends StatefulWidget {
  const RespiratoryRateDetails({super.key});

  @override
  State<RespiratoryRateDetails> createState() => _RespiratoryRateDetailsState();
}

class _RespiratoryRateDetailsState extends State<RespiratoryRateDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _respAnimationController;
  int _respRate = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _respAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),  // Adjusted duration for smoother movement
    )..repeat();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _respRate = 15;
      });
    });
  }

  @override
  void dispose() {
    _respAnimationController.dispose();
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
            // RR Label and Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RR',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '30',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '8',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Respiratory Rate Value
            Center(
              child: Text(
                _respRate.toString(),
                style: const TextStyle(
                  color: Colors.blue,
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
                  'Resp',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/min',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Respiratory Waveform
            ClipRect(
              child: SizedBox(
                height: 40,
                child: AnimatedBuilder(
                  animation: _respAnimationController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: RespWaveformPainter(
                        progress: _respAnimationController.value,
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

class RespWaveformPainter extends CustomPainter {
  final double progress;

  RespWaveformPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
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
      final y = height / 2 + amplitude * math.sin(currentProgress * 2 * math.pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RespWaveformPainter oldDelegate) =>
      progress != oldDelegate.progress;
} 