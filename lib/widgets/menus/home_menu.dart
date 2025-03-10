import 'package:flutter/material.dart';
import '../popups/views_popup.dart';
import '../popups/alarm_settings_popup.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  String selectedItem = 'HOME';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getImagePath(String item) {
    switch (item) {
      case 'HOME':
        return selectedItem == item 
            ? 'assets/images/Homesel.png'
            : 'assets/images/Homeunsel.png';
      case 'PATIENT INFO':
        return selectedItem == item 
            ? 'assets/images/Patientinfosel.png'
            : 'assets/images/Patientinfounsel.png';
      case 'VIEWS':
        return selectedItem == item 
            ? 'assets/images/viewsSel.png'
            : 'assets/images/viewsUnsel.png';
      case 'ALARM':
        return selectedItem == item 
            ? 'assets/images/Alarmsel.png'
            : 'assets/images/AlarmUnsel.png';
      case 'PARAMETER':
        return selectedItem == item 
            ? 'assets/images/parameterSel.png'
            : 'assets/images/parameterunsel.png';
      case 'HIST':
        return selectedItem == item 
            ? 'assets/images/histsel.png'
            : 'assets/images/histunsel.png';
      case 'TIME':
        return selectedItem == item 
            ? 'assets/images/timer.png'
            : 'assets/images/timer.png';
      case 'TRENDS':
        return selectedItem == item 
            ? 'assets/images/trendssel.png'
            : 'assets/images/trendsunsel.png';
      case 'SETTINGS':
        return selectedItem == item 
            ? 'assets/images/settingssel.png'
            : 'assets/images/settingsunsel.png';
      case 'MUTE':
        return selectedItem == item 
            ? 'assets/images/MuteSel.png'
            : 'assets/images/MuteUnsel.png';
      case 'LOCK':
        return selectedItem == item 
            ? 'assets/images/Locksel.png'
            : 'assets/images/Lockunsel.png';
      case 'STANDBY':
        return selectedItem == item 
            ? 'assets/images/standbysel.png'
            : 'assets/images/standbyunsel.png';
      case 'NIBP':
        return selectedItem == item
            ? 'assets/images/NIBPSel.png'
            : 'assets/images/NIBPUnsel.png';
      default:
        return 'assets/images/Homeunsel.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: MediaQuery.of(context).size.height - 82,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 1013,
            height: 57,
            decoration: BoxDecoration(
              color: const Color(0xFF343434),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuItem('HOME'),
                _buildMenuItem('PATIENT INFO'),
                _buildMenuItem('VIEWS'),
                _buildMenuItem('ALARM'),
                _buildMenuItem('NIBP'),
                _buildMenuItem('HIST'),
                _buildMenuItem('TIME'),
                _buildMenuItem('TRENDS'),
                _buildMenuItem('SETTINGS'),
                _buildMenuItem('MUTE'),
                _buildMenuItem('LOCK'),
                _buildMenuItem('STANDBY'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String label) {
    final isSelected = selectedItem == label;
    return InkWell(
      onTap: () {
        setState(() {
          selectedItem = label;
        });
        
        // Handle Views button click
        if (label == 'VIEWS') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ViewsPopup(),
          ).then((_) {
            setState(() {
              selectedItem = '';
            });
          });
        }

        // Handle Alarm button click
        if (label == 'ALARM') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlarmSettingsPopup(),
          ).then((_) {
            setState(() {
              selectedItem = '';
            });
          });
        }

        // Handle Standby button click
        if (label == 'STANDBY') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF343434),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text(
                'Confirm Standby',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Are you sure you want to exit the application?',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
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
                    // Completely terminate the app
                    if (Platform.isAndroid) {
                      SystemNavigator.pop(); // Exits app on Android
                    } else if (Platform.isIOS) {
                      exit(0); // Exits app on iOS
                    } else {
                      exit(0); // For other platforms
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ).then((_) {
            setState(() {
              selectedItem = '';
            });
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _getImagePath(label),
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 