import 'package:flutter/material.dart';

class ParameterMenu extends StatelessWidget {
  const ParameterMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1024,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: const Color(0xFF00FD0C),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.count(
        crossAxisCount: 6,
        padding: const EdgeInsets.all(16),
        children: const [
          ParameterItem(label: 'ECG', value: 'ON'),
          ParameterItem(label: 'NIBP', value: 'ON'),
          ParameterItem(label: 'SpO2', value: 'ON'),
          ParameterItem(label: 'RESP', value: 'ON'),
          ParameterItem(label: 'TEMP', value: 'ON'),
          ParameterItem(label: 'IBP', value: 'OFF'),
          ParameterItem(label: 'EtCO2', value: 'OFF'),
          ParameterItem(label: 'CARDIAC', value: 'OFF'),
          ParameterItem(label: 'ST', value: 'ON'),
          ParameterItem(label: 'ARR', value: 'ON'),
          ParameterItem(label: 'PACING', value: 'OFF'),
          ParameterItem(label: 'GAS', value: 'OFF'),
        ],
      ),
    );
  }
}

class ParameterItem extends StatelessWidget {
  final String label;
  final String value;

  const ParameterItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00FD0C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF00FD0C),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF00FD0C),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
} 