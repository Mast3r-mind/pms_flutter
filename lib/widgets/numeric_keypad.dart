import 'package:flutter/material.dart';

class NumericKeypad extends StatefulWidget {
  final Function(String) onValueChanged;
  final String initialValue;

  const NumericKeypad({
    Key? key,
    required this.onValueChanged,
    this.initialValue = '',
  }) : super(key: key);

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  final List<List<String>> keypadLayout = [
    ['1', '2', '3', '←'],
    ['4', '5', '6', '0'],
    ['7', '8', '9', '.', '⟵'],
  ];

  void _handleKeyPress(String key) {
    setState(() {
      if (key == '←' || key == '⟵') {
        if (currentValue.isNotEmpty) {
          currentValue = currentValue.substring(0, currentValue.length - 1);
        }
      } else if (key == '.' && !currentValue.contains('.')) {
        currentValue += key;
      } else if (key != '.') {
        currentValue += key;
      }
      widget.onValueChanged(currentValue);
    });
  }

  Widget _buildKey(String key) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        border: Border.all(color: const Color(0xFF559690), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _handleKeyPress(key),
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF559690)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with display and buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentValue,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Color(0xFF559690),
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Keypad layout
            ...keypadLayout.map((row) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((key) => _buildKey(key)).toList(),
            )),
          ],
        ),
      ),
    );
  }
} 