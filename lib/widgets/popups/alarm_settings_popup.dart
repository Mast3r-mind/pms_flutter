import 'package:flutter/material.dart';
import 'tabs/rr_tab_content.dart';
import 'tabs/spo2_tab_content.dart';
import 'tabs/temp_tab_content.dart';
import 'tabs/nibp_tab_content.dart';

class AlarmSettingsPopup extends StatefulWidget {
  const AlarmSettingsPopup({Key? key}) : super(key: key);

  @override
  State<AlarmSettingsPopup> createState() => _AlarmSettingsPopupState();
}

class _AlarmSettingsPopupState extends State<AlarmSettingsPopup> {
  String selectedTab = 'HR';
  bool stAlarmEnabled = true;
  int lowerLimit = 60;
  int upperLimit = 120;

  void _incrementLimit(bool isUpper) {
    setState(() {
      if (isUpper) {
        if (upperLimit < 200) upperLimit++;
      } else {
        if (lowerLimit < upperLimit - 1) lowerLimit++;
      }
    });
  }

  void _decrementLimit(bool isUpper) {
    setState(() {
      if (isUpper) {
        if (upperLimit > lowerLimit + 1) upperLimit--;
      } else {
        if (lowerLimit > 30) lowerLimit--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF343434),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 500,
        height: 500,
        child: Column(
          children: [
            // Header with dark background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: const BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ALARM SETTINGS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    // constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Tab buttons with bottom line
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.only(bottom: 2),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF006C58),
                    width: 2,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Row(
                  children: [
                    _buildTabButton('HR'),
                    _buildTabButton('Arrhythmia'),
                    _buildTabButton('RR'),
                    _buildTabButton('SpO₂'),
                    _buildTabButton('Temp'),
                    _buildTabButton('NIBP'),
                  ],
                ),
              ),
            ),
            // Content area
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSelectedTabContent(),
                  ],
                ),
              ),
            ),
            // Save button
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006C58),
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text) {
    final isSelected = selectedTab == text;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? const Color(0xFF006C58) : const Color(0xFF343434),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF006C58) : Colors.grey,
                ),
              ),
            ),
            onPressed: () => setState(() => selectedTab = text),
            child: Text(text),
          ),
        ),
        // Bottom line indicator
        Container(
          height: 2,
          width: text.length * 8.0 + 24, // Adjust width based on text length
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF006C58) : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedTabContent() {
    switch (selectedTab) {
      case 'RR':
        return const RRTabContent();
      case 'HR':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Labels row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox(width: 80),
                  const Text(
                    'Lower Limit',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 120),
                  const Text(
                    'Upper Limit',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Controls row
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Text(
                    'HR:',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 24),
                  _buildNumberControl(false),
                  const SizedBox(width: 140),
                  _buildNumberControl(true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ST Alarm
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Text(
                    'ST Alarm:',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  _buildDropdown(['ON', 'OFF'], 'ON'),
                ],
              ),
            ),
          ],
        );
      case 'SpO₂':
        return const SpO2TabContent();
      case 'Temp':
        return const TempTabContent();
      case 'NIBP':
        return const NIBPTabContent();
      default:
        return Container();
    }
  }

  Widget _buildNumberControl(bool isUpper) {
    final value = isUpper ? upperLimit : lowerLimit;
    
    return Container(
      width: 90,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minus button with green background
          Container(
            width: 25,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF006C58),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove, color: Colors.white, size: 20),
              onPressed: () => _decrementLimit(isUpper),
            ),
          ),
          // Value display with dark grey background
          Container(
            width: 40,
            height: 36,
            color: const Color(0xFF2A2A2A),
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Plus button with green background
          Container(
            width: 25,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF006C58),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () => _incrementLimit(isUpper),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String initialValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: DropdownButton<String>(
        value: initialValue,
        dropdownColor: const Color(0xFF2A2A2A),
        style: const TextStyle(color: Colors.white),
        underline: const SizedBox(),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {},
      ),
    );
  }
} 