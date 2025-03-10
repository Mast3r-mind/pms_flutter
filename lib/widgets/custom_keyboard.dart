import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final Function(String) onValueChanged;
  final String initialValue;

  const CustomKeyboard({
    Key? key,
    required this.onValueChanged,
    this.initialValue = '',
  }) : super(key: key);
  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  final List<List<String>> keypadLayout = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'ß'],
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'ü'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'ö', 'ä'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm', '+', '.', '-', ','],
  ];

  void _handleKeyPress(String key) {
    setState(() {
      currentValue += key;
      widget.onValueChanged(currentValue);
    });
  }

  void _handleBackspace() {
    if (currentValue.isNotEmpty) {
      setState(() {
        currentValue = currentValue.substring(0, currentValue.length - 1);
        widget.onValueChanged(currentValue);
      });
    }
  }

  Widget _buildKey(String label) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        border: Border.all(color: const Color(0xFF559690), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _handleKeyPress(label),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
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
            // Display field
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
                        icon: const Icon(Icons.backspace, color: Colors.white),
                        onPressed: _handleBackspace,
                      ),
                      IconButton(
                        icon: const Icon(Icons.check, color: Color(0xFF559690)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Keyboard layout
            ...keypadLayout.map((row) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((key) => Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  border: Border.all(color: const Color(0xFF559690), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () => _handleKeyPress(key),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      key,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            )),

            // Bottom row with space
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildKey('⇧'),
                _buildKey('→|'),
                Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    border: Border.all(color: const Color(0xFF559690), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () => _handleKeyPress(' '),
                    child: Container(
                      width: 200,
                      height: 40,
                    ),
                  ),
                ),
                _buildKey('<'),
                _buildKey('←'),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 