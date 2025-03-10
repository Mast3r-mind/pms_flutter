import 'package:flutter/material.dart';

class ECGTabContent extends StatefulWidget {
  const ECGTabContent({Key? key}) : super(key: key);

  @override
  State<ECGTabContent> createState() => _ECGTabContentState();
}

class _ECGTabContentState extends State<ECGTabContent> {
  Map<String, bool> ecgSelections = {
    'Select all': true,
    'ECG I': true,
    'ECG II': true,
    'ECG III': true,
    'aVR': true,
    'aVL': true,
    'aVF': true,
    'V': true,
  };

  void _toggleSelectAll(bool? value) {
    setState(() {
      ecgSelections['Select all'] = value ?? false;
      ecgSelections.forEach((key, _) {
        if (key != 'Select all') {
          ecgSelections[key] = value ?? false;
        }
      });
    });
  }

  void _toggleSelection(String key, bool? value) {
    setState(() {
      ecgSelections[key] = value ?? false;
      // Update 'Select all' based on other selections
      ecgSelections['Select all'] = ecgSelections.entries
          .where((entry) => entry.key != 'Select all')
          .every((entry) => entry.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckbox('Select all', ecgSelections['Select all']!),
              _buildCheckbox('ECG I', ecgSelections['ECG I']!),
              _buildCheckbox('ECG II', ecgSelections['ECG II']!),
              _buildCheckbox('ECG III', ecgSelections['ECG III']!),
            ],
          ),
        ),
        // Right column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckbox('aVR', ecgSelections['aVR']!),
              _buildCheckbox('aVL', ecgSelections['aVL']!),
              _buildCheckbox('aVF', ecgSelections['aVF']!),
              _buildCheckbox('V', ecgSelections['V']!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                if (label == 'Select all') {
                  _toggleSelectAll(newValue);
                } else {
                  _toggleSelection(label, newValue);
                }
              },
              activeColor: const Color(0xFF006C58),
              checkColor: Colors.white,
              side: const BorderSide(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 