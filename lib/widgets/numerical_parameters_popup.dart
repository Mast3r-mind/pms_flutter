import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../screens/patient_monitor_screen.dart';
import 'custom_keyboard.dart';  // Make sure to import the custom keyboard
import 'heart_rate_component.dart';  // Add this import
import 'heart_rate_details.dart';
import 'respiratory_rate_details.dart';
import 'temperature_details.dart';
import 'spo2_details.dart';
import 'nibp_details.dart';  // Make sure this import is correct
import 'st_details.dart'; 

class NumericalParametersPopup extends StatefulWidget {
  const NumericalParametersPopup({super.key});

  @override
  State<NumericalParametersPopup> createState() => _NumericalParametersPopupState();
}

class _NumericalParametersPopupState extends State<NumericalParametersPopup> {
  static const backgroundColor = Color(0xFF343434);

  
  late Timer _timer;
  String _currentValue = '';
  String _displayText = 'PAT 001';
  String _currentText = '';
  String _selectedType = 'ADULT';  // Default selection
  String selectedPatientType = 'ADULT';
  final List<String> patientTypes = ['ADULT', 'PEDIATRIC', 'NEONATE'];

  // Map to store image paths for each type
  final Map<String, String> _typeImages = {
    'ADULT': 'assets/images/adult.png',
    'PEDIATRIC': 'assets/images/pediatrics.png',
    'NEONATE': 'assets/images/newborn.png',
  };

  @override
  void initState() {
    super.initState();
    // Start timer to update values every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Helper method to update integer values within range
  int _updateValue(int current, int min, int max, int step) {
    int newValue = current + (Random().nextBool() ? step : -step);
    if (newValue > max) return max;
    if (newValue < min) return min;
    return newValue;
  }

  // Helper method to update double values within range
  double _updateDoubleValue(double current, double min, double max, double step) {
    double newValue = current + (Random().nextBool() ? step : -step);
    if (newValue > max) return max;
    if (newValue < min) return min;
    return double.parse(newValue.toStringAsFixed(1));
  }

  void _showCustomKeyboard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 600,  // Reduced width
            padding: const EdgeInsets.all(12),  // Reduced padding
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              // border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomKeyboard(
              initialValue: _currentValue,
              onValueChanged: (String value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _showTypeOptions(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 200,  // Position just below the header
              right: 1170,  // Align with the ADULT selector
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: const Color(0xFF000000)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,  // Align items to start
                    children: [
                      _buildTypeOption('ADULT'),
                      Container(
                        height: 1,
                        color: const Color(0xFF000000),
                      ),
                      _buildTypeOption('PEDIATRIC'),
                      Container(
                        height: 1,
                        color: const Color(0xFF000000),
                      ),
                      _buildTypeOption('NEONATE'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeOption(String type) {
    return InkWell(
      onTap: () {
        setState(() => _selectedType = type);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: _selectedType == type ? Colors.black : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,  // Align items to start
          children: [
            Image.asset(
              _typeImages[type]!,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF343434),
      insetPadding: EdgeInsets.zero,
      child: SizedBox.expand(
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! < 0) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PatientMonitorScreen(),
                ),
              );
            }
          },
          child: Container(
            width: 1024,
            height: 768,
            decoration: BoxDecoration(
              color: const Color(0xFF343434),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 3),
                // Header section with updated dimensions and vertical line
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Added this
                      children: [
                        // Left side content
                        Row(
                          children: [
                            Text(
                              _displayText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Vertical line
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              _selectedType,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Right side content with more spacing
                        Row(
                          children: [
                            const Icon(
                              Icons.wifi,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 12),  // Increased spacing
                            const Icon(
                              Icons.battery_full,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 16),  // Increased spacing
                            
                            const SizedBox(width: 8),  // Added right padding
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),  // Reduced from 20 to 12
                // Components arrangement
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: const [
                            SizedBox(height: -12),
                            HeartRateDetails(),
                            SizedBox(height: 8),
                            SPO2Details(),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(height: -8),
                            RespiratoryRateDetails(),
                            SizedBox(height: 8),
                            NIBPDetails(),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: const [
                            SizedBox(height: -8),
                            TemperatureDetails(),
                            SizedBox(height: 8),
                            STDetails(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 