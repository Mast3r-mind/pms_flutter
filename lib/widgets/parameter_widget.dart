import 'package:flutter/material.dart';

class ParameterWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color color;
  final bool isLarge;
  final Size? customSize;

  const ParameterWidget({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
    this.isLarge = false,
    this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: customSize?.width ?? (isLarge ? 279 : 150),
      height: customSize?.height ?? (isLarge ? 188 : 100),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            color: color.withOpacity(0.3),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: customSize != null ? 20 : (isLarge ? 24 : 16),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: color,
                      fontSize: customSize != null ? 36 : (isLarge ? 48 : 24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    unit,
                    style: TextStyle(
                      color: color,
                      fontSize: customSize != null ? 18 : (isLarge ? 24 : 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 