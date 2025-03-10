import 'package:flutter/material.dart';
import '../widgets/patient_details_popup.dart';
import '../widgets/popups/alarm_settings_popup.dart';

class BottomMenuComponent extends StatelessWidget {
  const BottomMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color(0xFF1F1F1F),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Patient Info Button with Image
          IconButton(
            icon: Image.asset(
              'assets/images/Patientinfounsel.png',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const PatientDetailsPopup(),
              );
            },
          ),
          // Alarm Settings Button
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AlarmSettingsPopup(),
              );
            },
          ),
          // Add other menu items here
        ],
      ),
    );
  }
} 