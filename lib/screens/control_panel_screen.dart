import 'package:flutter/material.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({Key? key}) : super(key: key);

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'label': 'HOME', 'isEnabled': true},
    {'icon': Icons.person, 'label': 'PATIENT INFO', 'isEnabled': true},
    {'icon': Icons.visibility, 'label': 'VIEWS', 'isEnabled': true},
    {'icon': Icons.warning, 'label': 'ALARM', 'isEnabled': true},
    {'icon': Icons.settings_applications, 'label': 'PARAMETER', 'isEnabled': true},
    {'icon': Icons.monitor_heart, 'label': 'NIBP', 'isEnabled': true},
    {'icon': Icons.trending_up, 'label': 'TRENDS', 'isEnabled': true},
    {'icon': Icons.settings, 'label': 'SETTINGS', 'isEnabled': true},
    {'icon': Icons.image, 'label': 'IMAGE', 'isEnabled': true},
    {'icon': Icons.logout, 'label': 'DISCHARGE', 'isEnabled': true},
    {'icon': Icons.volume_off, 'label': 'MUTE', 'isEnabled': true},
    {'icon': Icons.lock, 'label': 'LOCK', 'isEnabled': true},
    {'icon': Icons.power_settings_new, 'label': 'STANDBY', 'isEnabled': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Control Panel'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF343434),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: item['isEnabled'] ? Colors.white : Colors.grey,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['label'] as String,
                          style: TextStyle(
                            color: item['isEnabled'] ? Colors.white : Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Switch(
                          value: item['isEnabled'] as bool,
                          onChanged: (value) {
                            setState(() {
                              menuItems[index]['isEnabled'] = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ],
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