import 'package:flutter/material.dart';

class ECGLeadSettingsPopup extends StatefulWidget {
  const ECGLeadSettingsPopup({Key? key}) : super(key: key);

  @override
  State<ECGLeadSettingsPopup> createState() => _ECGLeadSettingsPopupState();
}

class _ECGLeadSettingsPopupState extends State<ECGLeadSettingsPopup> {
  String selectedMode = 'Monitoring';
  String selectedGain = 'Auto';
  String selectedSpeed = '25';

  final List<String> modes = ['Monitoring', 'Diagnostic', 'Surgical', 'ST'];
  final List<String> gains = ['Auto', '0.5x', '1x', '2x', '4x'];
  final List<String> speeds = ['0.625', '6.25', '12.5', '25', '50'];

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.black,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.green, width: 1),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mode Selection
            const Text(
              'Mode',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: modes.map((mode) {
                return _buildOptionButton(
                  mode,
                  selectedMode == mode,
                  () => setState(() => selectedMode = mode),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Gain Selection
            const Text(
              'Gain',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: gains.map((gain) {
                return _buildOptionButton(
                  gain,
                  selectedGain == gain,
                  () => setState(() => selectedGain = gain),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Sweep Speed Selection
            const Text(
              'Sweep Speed (mm/s)',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: speeds.map((speed) {
                return _buildOptionButton(
                  speed,
                  selectedSpeed == speed,
                  () => setState(() => selectedSpeed = speed),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // OK/Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop({
                      'mode': selectedMode,
                      'gain': selectedGain,
                      'speed': selectedSpeed,
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 