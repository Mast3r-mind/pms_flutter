import 'package:flutter/material.dart';

class PPGWaveformPopup extends StatefulWidget {
  final Color ppgColor;

  const PPGWaveformPopup({
    Key? key,
    required this.ppgColor,
  }) : super(key: key);

  @override
  State<PPGWaveformPopup> createState() => _PPGWaveformPopupState();

  static void show(BuildContext context, Color ppgColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PPGWaveformPopup(ppgColor: ppgColor),
    );
  }
}

class _PPGWaveformPopupState extends State<PPGWaveformPopup> {
  String selectedGain = 'Auto';
  String selectedSpeed = '25';
  String selectedWaveform = 'Pleth';
  bool showGainOptions = false;
  bool showSpeedOptions = false;
  bool showWaveformOptions = false;

  Widget buildSelectionOptions({
    required String title,
    required List<String> options,
    required Function(String) onSelect,
    bool showUnit = false,
    String? unit,
  }) {
    const waveformColor = Color(0xff559690);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(0.5),
              foregroundColor: waveformColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            onPressed: () {
              onSelect(option);
              setState(() {
                if (title == 'Gain') showGainOptions = false;
                if (title == 'Sweep Speed') showSpeedOptions = false;
                if (title == 'Waveform') showWaveformOptions = false;
              });
            },
            child: Text(
              showUnit ? '$option ${unit ?? ''}' : option,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildLabelValuePair({
      required String label,
      required String value,
      required VoidCallback onTap,
      required bool showOptions,
      bool isWaveform = false,
    }) {
      return Row(
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            ' :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTap,
            child: Container(
              width: isWaveform ? 150 : null,
              padding: EdgeInsets.symmetric(
                horizontal: isWaveform ? 24 : 12,
                vertical: isWaveform ? 12 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWaveform ? 16 : 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: isWaveform ? TextAlign.center : TextAlign.left,
              ),
            ),
          ),
        ],
      );
    }

    return Dialog(
      backgroundColor: const Color(0xff343434),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xff343434),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pleth',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),

            buildLabelValuePair(
              label: 'Choose Waveform',
              value: selectedWaveform,
              onTap: () => setState(() => showWaveformOptions = !showWaveformOptions),
              showOptions: showWaveformOptions,
              isWaveform: true,
            ),
            if (showWaveformOptions)
              buildSelectionOptions(
                title: 'Waveform',
                options: ['Lead I', 'Lead II', 'Lead III', 'AVR', 'AVF', 'AVL', 'V', 'Resp', 'Pleth'],
                onSelect: (waveform) => setState(() => selectedWaveform = waveform),
              ),

            const SizedBox(height: 12),

            buildLabelValuePair(
              label: 'Gain',
              value: selectedGain,
              onTap: () => setState(() => showGainOptions = !showGainOptions),
              showOptions: showGainOptions,
            ),
            if (showGainOptions)
              buildSelectionOptions(
                title: 'Gain',
                options: ['Auto', '0.5x', '1x', '2x', '4x'],
                onSelect: (gain) => setState(() => selectedGain = gain),
              ),

            const SizedBox(height: 12),

            buildLabelValuePair(
              label: 'Sweep Speed',
              value: '$selectedSpeed mm/s',
              onTap: () => setState(() => showSpeedOptions = !showSpeedOptions),
              showOptions: showSpeedOptions,
            ),
            if (showSpeedOptions)
              buildSelectionOptions(
                title: 'Sweep Speed',
                options: ['0.625', '6.25', '12.5', '25', '50'],
                onSelect: (speed) => setState(() => selectedSpeed = speed),
                showUnit: true,
                unit: 'mm/s',
              ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
} 