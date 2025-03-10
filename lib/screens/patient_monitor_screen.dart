import 'package:flutter/material.dart';
import '../widgets/waveform_widget.dart';
import '../widgets/parameter_widget.dart';
import '../widgets/ecg_component.dart';
import '../widgets/vital_waveforms_component.dart';
import '../widgets/st_component_widget.dart';
import '../widgets/bottom_menu_component.dart';
import '../widgets/top_rectangle_component.dart';
import '../widgets/wifi_status_component.dart';
import '../widgets/battery_icon_component.dart';
import '../widgets/vertical_line_component.dart';
import '../widgets/date_component.dart';
import '../widgets/heart_rate_component.dart';
import '../widgets/nibp_component.dart';
import '../widgets/resp_rate_component.dart';
import '../widgets/spo2_parameter_component.dart';
import '../widgets/temperature_component.dart';
import '../widgets/ecg_detail_popup.dart';
import '../widgets/numerical_parameters_popup.dart';
import '../widgets/time_component.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform, exit;


class PatientMonitorScreen extends StatefulWidget {
  const PatientMonitorScreen({Key? key}) : super(key: key);

  @override
  State<PatientMonitorScreen> createState() => _PatientMonitorScreenState();
}

class _PatientMonitorScreenState extends State<PatientMonitorScreen> {
  final Map<String, Offset> widgetPositions = {};

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog
        final shouldPop = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF343434),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: const Text(
              'Confirm Exit',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Are you sure you want to exit the application?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006C58),
                ),
                onPressed: () {
                  // Perform any cleanup here
                  
                  // Exit the app
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  } else {
                    exit(0);
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: SizedBox.expand(
        child: GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction
            if (details.delta.dx > 0) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const NumericalParametersPopup(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF343434),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (details) {
                // Swiping right to open ECG popup
                if (details.delta.dx > 10) {
                  _showECGDetailPopup(context);
                }
              },
              child: Container(
                width: 1024,
                height: 768,
                decoration: const BoxDecoration(
                  color: Color(0xFF343434),
                ),
                child: Stack(
                  children: [
                    // Top Rectangle
                    Positioned(
                      left: 4,
                      top: 4,
                      child: TopRectangleComponent(),
                    ),

                    // Vital Waveforms Component with specific bounds
                    Positioned(
                      left: 6,
                      top: 66,
                      child: Container(
                        width: 723,
                        height: 516,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: const VitalWaveformsComponent(
                          ecgColor: Color(0xFF00FF00),
                        ),
                      ),
                    ),

                    // New NIBP Component
                    const Positioned(
                      left: 737,
                      top: 182,
                      child: NIBPComponent(),
                    ),

                    // Heart Rate Rectangle
                    Positioned(
                      left: 737,
                      top: 66,
                      child: Container(
                        width: 281,  // 1018 - 737 = 281
                        height: 112, // 183 - 73 = 110
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: const Color(0xFF000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const HeartRateComponent(),
                      ),
                    ),

                    // Remove or comment out the Temperature Parameter Component
                    // const Positioned(
                    //   left: 737,
                    //   top: 647,
                    //   width: 279,
                    //   height: 188,
                    //   child: TemperatureComponent(),
                    // ),

                    // New Respiratory Rate Component
                    const Positioned(
                      left: 737,
                      top: 365,  // Changed from 360 to 365 to move down
                      child: RespRateContainer(),
                    ),

                    // ST Analysis Parameter with values
                    Positioned(
                      left: 7,
                      top: 586,
                      child: SizedBox(
                        width: 723,
                        height: 175,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: const Color(0xFF000000),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ST',
                                style: TextStyle(
                                  color: Color(0xFF00FF00),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left column (I, II, III)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'I  0.08',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'II  0.10',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'III  0.02',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40),
                                  // Middle column (aVR, aVL, aVF)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'aVR -0.09',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'aVL -0.06',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'aVF -0.03',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40),
                                  // Right column (V)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'V  0.04',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // mV unit
                                  const Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Text(
                                      'mV',
                                      style: TextStyle(
                                        color: Color(0xFF00FF00),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Remove or comment out the old parameter positions

                    // // Bottom Menu
                    // Positioned(
                    //   left: 420,
                    //   top: 707,
                    //   child: BottomMenuComponent(),
                    // ),

                    // Vertical Line before WiFi
                    const Positioned(
                      left: 743,  // X coordinate from point1
                      top: 11,   // Y coordinate from point1
                      child: VerticalLineComponent(),
                    ),

                    // WiFi Status
                    const Positioned(
                      left: 812,
                      top: 18,
                      child: WifiStatusComponent(),
                    ),

                    // First Battery Icon
                    const Positioned(
                      left: 840,
                      top: 8,
                      child: BatteryIconComponent(),
                    ),
                    
                    // Second Battery Icon
                    const Positioned(
                      left: 876,  // Updated to new x position
                      top: 8,
                      child: BatteryIconComponent(),
                    ),

                    // Date Component
                    const Positioned(
                      left: 918,
                      top: 12,
                      child: DateComponent(),
                    ),
                    
                    // Add Time Component
                    const Positioned(
                      left: 918,
                      top: 30,  // Positioned below the date
                      child: TimeComponent(),
                    ),

                    // New SpO2 Parameter Component
                    const Positioned(
                      left: 737,
                      top: 495,
                      child: SpO2ParameterComponent(),
                    ),

                    // Temperature Component with updated bounds
                    Positioned(
                      left: 736,
                      top: 637,
                      child: Container(
                        width: 281,  // 1017 - 736
                        height: 126, // 763 - 637
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: const Color(0xFF000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const TemperatureComponent(),
                      ),
                    ),

                    // Add BottomMenuComponent
                    Positioned(
                      left: 420,
                      bottom: 4,
                      child: const BottomMenuComponent(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableWidget(String id, Widget child, Offset initialPosition) {
    widgetPositions.putIfAbsent(id, () => initialPosition);

    return Positioned(
      left: widgetPositions[id]!.dx,
      top: widgetPositions[id]!.dy,
      child: Draggable(
        feedback: child,
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: child,
        ),
        onDragEnd: (details) {
          setState(() {
            widgetPositions[id] = details.offset;
          });
        },
        child: child,
      ),
    );
  }

  void _showECGDetailPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext context) => const ECGDetailPopup(),
    );
  }
}

class RespRateContainer extends StatelessWidget {
  const RespRateContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 281,
      height: 124,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: const RespRateComponent(),
    );
  }
} 
