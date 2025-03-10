import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'numerical_parameters_popup.dart';
import 'heart_rate_component.dart';
import 'nibp_component.dart';
import 'spo2_parameter_component.dart';
import 'temperature_component.dart';
import 'st_component_widget.dart';
import 'resp_rate_component.dart';
import 'patient_details_popup.dart';
import 'dart:async';
import 'package:intl/intl.dart';
// import 'spo2_details.dart';

class ECGDetailPopup extends StatefulWidget {
  const ECGDetailPopup({Key? key}) : super(key: key);

  @override
  State<ECGDetailPopup> createState() => _ECGDetailPopupState();
}

class _ECGDetailPopupState extends State<ECGDetailPopup> {
  late Timer _timer;
  String _currentDateTime = '';

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateDateTime() {
    setState(() {
      _currentDateTime = DateFormat('dd-MM-yyyy\nHH:mm').format(DateTime.now());
    });
  }

  // Add const to the map
  static const Map<String, String> _typeImages = {
    'ADULT': 'assets/images/adult.png',
    'PEDIATRIC': 'assets/images/pediatrics.png',
    'NEONATE': 'assets/images/newborn.png',
  };

  @override
  Widget build(BuildContext context) {
    final List<String> leads = ['I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V'];

    return Dialog(
      backgroundColor: const Color(0xFF343434),
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -10) {
            Navigator.of(context).pop();
          }
          if (details.delta.dx > 10) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) => const NumericalParametersPopup(),
            );
          }
        },
        child: Container(
          width: 1024,
          height: 768,
          color: const Color(0xFF343434),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 3),
                  // Top Rectangle with updated dimensions
                  Center(
                    child: Container(
                      width: 1013,
                      height: 57,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side - Patient Info
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    builder: (BuildContext context) => const PatientDetailsPopup(),
                                  );
                                },
                                child: MouseRegion(
                                  // cursor: SystemMouseCursors.click,
                                  child: const Text(
                                    'PAT 001',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Patient Type with icon - Updated
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/adult.png',  // Using adult image
                                    width: 20,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: const Text(
                                      'ADULT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Right side - Status Icons and Time
                          Row(
                            children: [
                              const Icon(
                                Icons.wifi,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.battery_full,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _currentDateTime,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ECG Waveforms with integrated header
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(4, 4, 290, 140),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // ECG Header inside waveform box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: [
                                const Text(
                                  'X5',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Monitoring',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.favorite_border,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'ECG',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // // Divider line
                          // Container(
                          //   height: 1,
                          //   color: Colors.grey.withOpacity(0.2),
                          // ),
                          // Waveforms
                          Expanded(
                            child: Row(
                              children: [
                                // Lead labels column
                                Container(
                                  width: 30,
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: leads.map((lead) {
                                      return Text(
                                        lead,
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 11,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                // Waveforms column
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(8),
                                    ),
                                    child: Column(
                                      children: leads.map((lead) {
                                        return Expanded(
                                          child: Container(
                                            // Removed the decoration with border
                                            child: const AnimatedECGWaveform(),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // HeartRateComponent
              Positioned(
                right: 6,
                top: 65,
                child: Container(
                  width: 281,
                  height: 108,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const HeartRateComponent(),
                ),
              ),
              // NIBPComponent
              Positioned(
                right: 6,
                top: 177,
                child: Container(
                  width: 281,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const NIBPComponent(),
                ),
              ),
              // Adjust RespRateComponent position
              Positioned(
                right: 6,
                top: 351,
                child: Container(
                  width: 281,
                  height: 118,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: const RespRateComponent(),
                ),
              ),
              // Adjust SPO2ParameterComponent position
              Positioned(
                right: 6,
                top: 473,  // Moved down to accommodate RespRateComponent
                child: Container(
                  width: 281,
                  height: 149,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const SpO2ParameterComponent(),
                ),
              ),
              // Move STComponentWidget to left side
              Positioned(
                left: 6,  // Align with ECG waveform container
                bottom: 4,
                child: Container(
                  width: 728,  // Increased from 715 to match new ECG width
                  height: 133,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const STComponentWidget(),
                ),
              ),
              // Keep TemperatureComponent on right side
              Positioned(
                right: 6,
                bottom: 4, // Adjusted to align with ST component
                child: Container(
                  width: 281,
                  height: 138,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const TemperatureComponent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedECGWaveform extends StatefulWidget {
  const AnimatedECGWaveform({Key? key}) : super(key: key);

  @override
  State<AnimatedECGWaveform> createState() => _AnimatedECGWaveformState();
}

class _AnimatedECGWaveformState extends State<AnimatedECGWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
          painter: ECGWaveformPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class ECGWaveformPainter extends CustomPainter {
  final double progress;

  ECGWaveformPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final segmentWidth = 100.0;  // Adjusted for proper spacing
    double x = -(1.0 - progress) * size.width;
    double y = size.height / 2;
    bool isFirstPoint = true;

    while (x < size.width + segmentWidth) {
      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      }

      // Baseline
      x += 10;
      path.lineTo(x, y);

      // QRS Complex
      // Q wave (small downward deflection)
      x += 5;
      path.lineTo(x, y + 4);
      
      // R wave (sharp upward spike)
      x += 4;
      path.lineTo(x, y - 30);
      
      // S wave (downward deflection)
      x += 4;
      path.lineTo(x, y + 8);
      
      // Return to baseline
      x += 4;
      path.lineTo(x, y);

      // ST segment
      x += 15;
      path.lineTo(x, y);

      // T wave (smooth upward curve)
      x += 10;
      path.quadraticBezierTo(
        x + 10, y - 8,  // control point
        x + 20, y      // end point
      );

      // Complete the cycle with baseline
      x += 28;
      path.lineTo(x, y);
    }

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ECGWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
} 