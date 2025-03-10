import 'package:flutter/material.dart';

class SpO2Parameter extends StatefulWidget {
  final String value;
  final String piValue;
  final Color color;
  final VoidCallback? onTap;

  const SpO2Parameter({
    Key? key,
    required this.value,
    required this.piValue,
    this.color = Colors.yellow,
    this.onTap,
  }) : super(key: key);

  @override
  State<SpO2Parameter> createState() => _SpO2ParameterState();
}

class _SpO2ParameterState extends State<SpO2Parameter> {
  bool isPressed = false;

  void _showSpO2Settings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text(
          'SpO2 Settings',
          style: TextStyle(color: widget.color),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSettingItem('Alarm Limits', '50-100'),
            _buildSettingItem('Averaging Time', '8 sec'),
            _buildSettingItem('Sensitivity Mode', 'Normal'),
            _buildSettingItem('Pulse Tone', 'On'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: widget.color),
            ),
          ),
          TextButton(
            onPressed: () {
              // Save settings logic here
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(color: widget.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: widget.color),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () {
        _showSpO2Settings(context);
        widget.onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: widget.color,
            width: isPressed ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SpO2',
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: widget.color,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.value,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '%',
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              widget.piValue,
              style: TextStyle(
                color: widget.color,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 