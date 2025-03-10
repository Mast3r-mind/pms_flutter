import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'animated_ecg_waveform.dart';
import 'animated_ppg_waveform.dart';
import 'animated_respiratory_waveform.dart';
import 'popups/ecg_lead_one_popup.dart';
import 'popups/ecg_lead_two_popup.dart';
import 'popups/ecg_lead_three_popup.dart';
import 'popups/ppg_waveform_popup.dart';
import 'popups/resp_waveform_popup.dart';
import 'dart:async';

class VitalWaveformsComponent extends StatefulWidget {
  final Color ecgColor;
  static const Color ppgColor = Color(0xFFFFFF00); // Yellow color
  static const Color respColor = Color(0xFF039BFC); // Changed to new blue color

  const VitalWaveformsComponent({
    Key? key,
    required this.ecgColor,
  }) : super(key: key);

  @override
  State<VitalWaveformsComponent> createState() => _VitalWaveformsComponentState();
}

class _VitalWaveformsComponentState extends State<VitalWaveformsComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final int bufferSize = 1000;
  final int visiblePoints = 200;
  final int updateStep = 4;      // Reduced for smoother updates
  final double gapSize = 20.0;   // Gap size between frames
  
  // ECG waveform buffers
  List<double> ecgIBuffer = [];
  List<double> ecgIIBuffer = [];
  List<double> ecgIIIBuffer = [];
  
  // Buffer indices
  int writeIndex = 0;
  int readIndex = 0;
  bool isGap = false;
  int gapCounter = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    
    // Initialize buffers
    ecgIBuffer = List.filled(bufferSize, 0.0);
    ecgIIBuffer = List.filled(bufferSize, 0.0);
    ecgIIIBuffer = List.filled(bufferSize, 0.0);

    // Update buffer at fixed intervals
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _updateCircularBuffer();
    });
  }

  void _updateCircularBuffer() {
    setState(() {
      if (isGap) {
        // Handle gap period
        gapCounter++;
        for (int i = 0; i < updateStep; i++) {
          ecgIBuffer[writeIndex] = 0.0;
          ecgIIBuffer[writeIndex] = 0.0;
          ecgIIIBuffer[writeIndex] = 0.0;
          writeIndex = (writeIndex + 1) % bufferSize;
        }
        
        if (gapCounter >= gapSize) {
          isGap = false;
          gapCounter = 0;
        }
      } else {
        // Generate normal ECG pattern
        for (int i = 0; i < updateStep; i++) {
          double valueI = _generateECGPoint(writeIndex);
          double valueII = _generateECGPoint(writeIndex + 20);
          double valueIII = _generateECGPoint(writeIndex + 40);

          ecgIBuffer[writeIndex] = valueI;
          ecgIIBuffer[writeIndex] = valueII;
          ecgIIIBuffer[writeIndex] = valueIII;

          writeIndex = (writeIndex + 1) % bufferSize;
          
          // Check if we should start a gap
          if (writeIndex % (visiblePoints ~/ 2) == 0) {
            isGap = true;
            break;
          }
        }
      }

      // Update read position for sweep effect
      readIndex = (writeIndex - visiblePoints + bufferSize) % bufferSize;
    });
  }

  double _generateECGPoint(int index) {
    final cycleLength = 100;  // Adjusted cycle length
    final position = index % cycleLength;
    
    if (position < 10) {
      // P wave
      return 0.25 * math.sin(position * math.pi / 10);
    } else if (position < 15) {
      // PR segment
      return 0;
    } else if (position == 15) {
      // Q wave
      return -0.3;
    } else if (position == 17) {
      // R wave
      return 1.0;
    } else if (position == 19) {
      // S wave
      return -0.4;
    } else if (position < 40) {
      // ST segment and T wave
      if (position > 25 && position < 35) {
        return 0.3 * math.sin((position - 25) * math.pi / 10);
      }
      return 0;
    } else {
      // Baseline
      return 0;
    }
  }

  List<double> getVisiblePoints(List<double> buffer) {
    List<double> points = [];
    int index = readIndex;
    
    for (int i = 0; i < visiblePoints; i++) {
      points.add(buffer[index]);
      index = (index + 1) % bufferSize;
    }
    
    return points;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // ECG Lead Controls
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 24,
            child: Row(
              children: [
                Icon(Icons.pause, color: widget.ecgColor, size: 16),
                const SizedBox(width: 16),
                Text('X5',
                    style: TextStyle(color: widget.ecgColor, fontWeight: FontWeight.bold)),
                const SizedBox(width: 32),
                Text('Monitoring',
                    style: TextStyle(color: widget.ecgColor, fontWeight: FontWeight.bold)),
                const Spacer(),
                Image.asset(
                  'assets/images/Pacemaker.png',
                  width: 16,
                  height: 16,
                  color: widget.ecgColor,
                ),
                const SizedBox(width: 4),
                Text('ECG',
                    style: TextStyle(color: widget.ecgColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // ECG Leads with Animation
          Expanded(
            flex: 3,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedECGWaveform(
                      color: widget.ecgColor,
                      height: 100,
                      title: 'ECG I',
                      sweepPosition: _animationController.value,
                      waveformPoints: getVisiblePoints(ecgIBuffer),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedECGWaveform(
                      color: widget.ecgColor,
                      height: 100,
                      title: 'ECG II',
                      sweepPosition: _animationController.value,
                      waveformPoints: getVisiblePoints(ecgIIBuffer),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedECGWaveform(
                      color: widget.ecgColor,
                      height: 100,
                      title: 'ECG III',
                      sweepPosition: _animationController.value,
                      waveformPoints: getVisiblePoints(ecgIIIBuffer),
                    );
                  },
                ),
              ],
            ),
          ),

          // Animated Pleth Waveform
          Expanded(
            child: _buildAnimatedPlethWaveform(),
          ),

          // Animated Resp Waveform
          Expanded(
            child: _buildAnimatedRespWaveform(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedPlethWaveform() {
    return GestureDetector(
      onTap: () {
        PPGWaveformPopup.show(context, VitalWaveformsComponent.ppgColor);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: PlethWaveformPainter(
              sweepPosition: _animationController.value,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: const [
                  Text('X1',
                      style: TextStyle(
                          color: Color(0xFFFFFF00), fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('Pleth',
                          style: TextStyle(
                          color: Color(0xFFFFFF00), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedRespWaveform() {
    return GestureDetector(
      onTap: () {
        RespWaveformPopup.show(context, VitalWaveformsComponent.respColor);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: RespWaveformPainter(
              sweepPosition: _animationController.value,
            ),
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: const [
                  Text('X1',
                          style: TextStyle(
                          color: Color(0xFF039BFC), fontWeight: FontWeight.bold)),
                  SizedBox(width: 16),
                  Text('Source:ECG',
                          style: TextStyle(
                          color: Color(0xFF039BFC), fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('RESP',
                          style: TextStyle(
                          color: Color(0xFF039BFC), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ECGWaveformPainter extends CustomPainter {
  final Color color;
  final double sweepPosition;
  final List<double> waveformPoints;

  ECGWaveformPainter({
    required this.color,
    required this.sweepPosition,
    required this.waveformPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    _drawGrid(canvas, size);

    final path = Path();
    final width = size.width;
    final height = size.height;
    final mid = height / 2;
    final segmentWidth = 100.0; // Adjusted for proper speed
    
    // Calculate starting position for sweep effect
    double x = -(1.0 - sweepPosition) * width;
    double y = mid;
    bool isFirstPoint = true;

    while (x < width + segmentWidth) {
      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      }

      // P wave (smoother)
      x += 12;
      path.cubicTo(
        x - 8, y - 2,
        x - 4, y - 4,
        x, y
      );

      // PR segment (shorter)
      x += 8;
      path.lineTo(x, y);

      // QRS complex (smoother transitions)
      x += 4;
      path.cubicTo(
        x, y + 1,
        x + 2, y + 3,
        x + 4, y + 3
      );
      x += 4;
      path.cubicTo(
        x, y - 30,
        x + 4, y - 35,
        x + 6, y - 35
      );
      x += 6;
      path.cubicTo(
        x, y - 35,
        x + 4, y + 6,
        x + 6, y + 6
      );

      // ST segment (smoother)
      x += 12;
      path.lineTo(x, y);

      // T wave (smoother)
      x += 16;
      path.cubicTo(
        x - 12, y,
        x - 8, y - 10,
        x - 4, y - 10
      );
      path.cubicTo(
        x, y - 10,
        x + 4, y - 8,
        x + 8, y
      );

      // Complete the cycle with gap
      x += 28;
      path.lineTo(x, y);
    }

    // Clip the waveform for sweep effect
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Vertical lines
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ECGWaveformPainter oldDelegate) {
    return oldDelegate.sweepPosition != sweepPosition;
  }
}

class PlethWaveformPainter extends CustomPainter {
  final double sweepPosition;

  PlethWaveformPainter({required this.sweepPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFFF00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    _drawGrid(canvas, size);

    final path = Path();
    final wavelength = 80.0;
    double x = -(1.0 - sweepPosition) * size.width;
    double y = size.height / 2;
    bool isFirstPoint = true;

    while (x < size.width + wavelength) {
      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      }

      x += wavelength;
      path.cubicTo(
        x - wavelength * 0.75, y - 25,
        x - wavelength * 0.25, y - 25,
        x, y
      );
    }

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PlethWaveformPainter oldDelegate) {
    return oldDelegate.sweepPosition != sweepPosition;
  }
}

class RespWaveformPainter extends CustomPainter {
  final double sweepPosition;

  RespWaveformPainter({required this.sweepPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF039BFC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    _drawGrid(canvas, size);

    final path = Path();
    final wavelength = 160.0;
    double x = -(1.0 - sweepPosition) * size.width;
    double y = size.height / 2;
    bool isFirstPoint = true;

    while (x < size.width + wavelength) {
      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      }

      x += wavelength;
      path.cubicTo(
        x - wavelength * 0.75, y - 15,
        x - wavelength * 0.25, y - 15,
        x, y
      );
    }

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant RespWaveformPainter oldDelegate) {
    return oldDelegate.sweepPosition != sweepPosition;
  }
}

class AnimatedECGWaveform extends StatelessWidget {
  final Color color;
  final double height;
  final String title;
  final double sweepPosition;
  final List<double> waveformPoints;

  const AnimatedECGWaveform({
    super.key,
    required this.color,
    required this.height,
    required this.title,
    required this.sweepPosition,
    required this.waveformPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
      child: CustomPaint(
        painter: ECGWaveformPainter(
          color: color,
          sweepPosition: sweepPosition,
          waveformPoints: waveformPoints,
        ),
        size: Size.infinite,
      ),
    );
  }
} 