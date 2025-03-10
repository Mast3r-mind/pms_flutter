import 'package:flutter/material.dart';

class STComponentWidget extends StatelessWidget {
  const STComponentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left section - ST label and waveform
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ST',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 40,
                  color: Colors.black,
                  // Add your ST waveform here
                ),
              ],
            ),
          ),
          
          // Middle section - I, II, III values
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'I  0.08',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'II  0.10',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'III  0.02',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Middle-right section - aVR, aVL, aVF values
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'aVR -0.09',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'aVL -0.06',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'aVF -0.03',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Right section - V value and mV
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'V 0.04',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Text(
                  'mV',
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 