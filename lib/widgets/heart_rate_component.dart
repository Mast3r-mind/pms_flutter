import 'package:flutter/material.dart';
import 'dart:async';

class HeartRateComponent extends StatefulWidget {
  const HeartRateComponent({super.key});

  @override
  State<HeartRateComponent> createState() => _HeartRateComponentState();
}

class _HeartRateComponentState extends State<HeartRateComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer _timer;
  late Timer? _blinkTimer;
  bool _showValue = true;
  bool _showAlert = true;
  bool _showParameter = true;
  int hrValue = 60;
  bool isIncreasing = true;
  final int upperLimit = 120;
  final int maxLimit = 150;
  final int lowerLimit = 55;
  bool isHRHigh = false;
  bool isHRLow = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (isIncreasing) {
          hrValue += 1;
          if (hrValue >= upperLimit && !isHRHigh) {
            isHRHigh = true;
            isHRLow = false;
            _showHRAlert('HR HIGH');
          }
          if (hrValue >= maxLimit) {
            isIncreasing = false;
          }
          if (hrValue > lowerLimit && isHRLow) {
            isHRLow = false;
            _hideAlert();
          }
        } else {
          hrValue -= 1;
          if (hrValue < upperLimit && isHRHigh) {
            isHRHigh = false;
            _hideAlert();
          }
          if (hrValue <= lowerLimit) {
            if (!isHRLow) {
              isHRLow = true;
              isHRHigh = false;
              _showHRAlert('HR LOW');
            }
            isIncreasing = true;
          }
        }
      });
    });
  }

  void _showHRAlert(String message) {
    setState(() {
      isHRHigh = message == 'HR HIGH';
      isHRLow = message == 'HR LOW';
    });

    _blinkTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      setState(() {
        _showAlert = !_showAlert;
        _showValue = !_showValue;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: Duration.zero,
        pageBuilder: (context, _, __) => StatefulBuilder(
          builder: (context, setState) {
            return ValueListenableBuilder<bool>(
              valueListenable: ValueNotifier<bool>(_showAlert),
              builder: (context, visible, child) {
                return AnimatedOpacity(
                  opacity: visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: IgnorePointer(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 500,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  void _hideAlert() {
    _blinkTimer?.cancel();
    _blinkTimer = null;
    Navigator.of(context).pop();
    setState(() {
      isHRHigh = false;
      isHRLow = false;
      _showAlert = true;
      _showValue = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _showParameter,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (isHRHigh || isHRLow) ? Colors.red : Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Stack(
          children: [
            // HR text at top left
            const Positioned(
              top: 2,
              left: 2,
              child: Text(
                'HR',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Max/Min values at top right corner
            const Positioned(
              top: 2,
              right: 2,
              child: Text(
                '120\n60',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            // Heart rate value with blinking
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: Visibility(
                visible: _showValue,
                child: Text(
                  hrValue.toString(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // bpm unit moved down more
            const Positioned(
              bottom: -4,
              right: 2,
              child: Text(
                'bpm',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Blinking heart at bottom left
            Positioned(
              left: 2,
              bottom: 2,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 24,
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
}